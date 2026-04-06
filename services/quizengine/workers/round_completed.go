package workers

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/quizbattle/server/internal/models"
	"github.com/quizbattle/server/internal/rabbitmq"
	"github.com/quizbattle/server/services/quizengine"
	"github.com/redis/go-redis/v9"
	"go.mongodb.org/mongo-driver/mongo"

	quizv1 "github.com/quizbattle/server/gen/quiz/v1"
)

type RoundCompletedEvent struct {
	RoomID string `json:"roomId"`
	Round  int32  `json:"round"`
}

type RoundCompletedWorker struct {
	rdb          *redis.Client
	selector     *quizengine.QuestionSelector
	roundManager *quizengine.RoundManager
	streamer     *quizengine.GameStreamer
}

func NewRoundCompletedWorker(db *mongo.Database, rdb *redis.Client, roundManager *quizengine.RoundManager, streamer *quizengine.GameStreamer) *RoundCompletedWorker {
	return &RoundCompletedWorker{
		rdb:          rdb,
		selector:     quizengine.NewQuestionSelector(db),
		roundManager: roundManager,
		streamer:     streamer,
	}
}

func (w *RoundCompletedWorker) Start(ctx context.Context, rmqConn *rabbitmq.Connection) error {
	consumer, err := rabbitmq.NewConsumer(rmqConn, "round-completed-queue", "round.completed", w.handle)
	if err != nil {
		return err
	}
	return consumer.Start(ctx)
}

func (w *RoundCompletedWorker) handle(ctx context.Context, body []byte) error {
	var event RoundCompletedEvent
	if err := json.Unmarshal(body, &event); err != nil {
		return err
	}

	log.Printf("Processing round.completed: room=%s round=%d", event.RoomID, event.Round)

	// Get the question for this round to broadcast the correct answer
	question, err := w.getQuestionForRound(ctx, event.RoomID, event.Round)
	if err != nil {
		log.Printf("Failed to get question for round result: %v", err)
	}

	// Broadcast round result
	if question != nil {
		// Get answers for this round
		answersKey := fmt.Sprintf("room:%s:answers:%d", event.RoomID, event.Round)
		answers, _ := w.rdb.HGetAll(ctx, answersKey).Result()

		playerResults := make([]*quizv1.PlayerRoundResult, 0, len(answers))
		for _, answerJSON := range answers {
			var answer quizengine.AnswerData
			if json.Unmarshal([]byte(answerJSON), &answer) == nil {
				playerResults = append(playerResults, &quizv1.PlayerRoundResult{
					UserId:         answer.UserID,
					Correct:        answer.Correct,
					PointsEarned:   0, // Will be filled by scoring service
					ResponseTimeMs: answer.ResponseTime,
				})
			}
		}

		roundResultEvent := &quizv1.GameEvent{
			Event: &quizv1.GameEvent_RoundResult{
				RoundResult: &quizv1.RoundResult{
					Round:              event.Round,
					CorrectOptionIndex: question.CorrectIndex,
					PlayerResults:      playerResults,
				},
			},
		}
		w.streamer.BroadcastToRoom(event.RoomID, roundResultEvent)
	}

	// Broadcast leaderboard update
	w.broadcastLeaderboard(ctx, event.RoomID, event.Round)

	// Check total rounds
	totalRounds, err := w.getTotalRounds(ctx, event.RoomID)
	if err != nil {
		return err
	}

	if event.Round >= totalRounds {
		// Match is over
		w.broadcastMatchEnd(ctx, event.RoomID)
		w.roundManager.FinishMatch(ctx, event.RoomID)
	} else {
		// Start next round after a delay
		nextRound := event.Round + 1
		nextQuestion, err := w.getQuestionForRound(ctx, event.RoomID, nextRound)
		if err != nil {
			return fmt.Errorf("failed to get next question: %w", err)
		}

		// Delay before next round (5 seconds for leaderboard viewing)
		go func() {
			select {
			case <-ctx.Done():
				return
			case <-timeAfter(5):
				w.roundManager.StartRound(context.Background(), event.RoomID, nextRound, *nextQuestion)
			}
		}()
	}

	return nil
}

func (w *RoundCompletedWorker) getQuestionForRound(ctx context.Context, roomID string, round int32) (*models.Question, error) {
	qKey := fmt.Sprintf("room:%s:questions", roomID)
	questionID, err := w.rdb.LIndex(ctx, qKey, int64(round-1)).Result()
	if err != nil {
		return nil, err
	}

	cacheKey := fmt.Sprintf("room:%s:question:%s", roomID, questionID)
	data, err := w.rdb.Get(ctx, cacheKey).Bytes()
	if err == nil {
		var q models.Question
		if json.Unmarshal(data, &q) == nil {
			return &q, nil
		}
	}

	return w.selector.GetByID(ctx, questionID)
}

func (w *RoundCompletedWorker) getTotalRounds(ctx context.Context, roomID string) (int32, error) {
	stateKey := fmt.Sprintf("room:%s:state", roomID)
	data, err := w.rdb.Get(ctx, stateKey).Bytes()
	if err != nil {
		return 5, nil // default
	}
	var state struct {
		TotalRounds int32 `json:"totalRounds"`
	}
	if json.Unmarshal(data, &state) != nil || state.TotalRounds == 0 {
		return 5, nil
	}
	return state.TotalRounds, nil
}

func (w *RoundCompletedWorker) broadcastLeaderboard(ctx context.Context, roomID string, afterRound int32) {
	lbKey := fmt.Sprintf("room:%s:leaderboard", roomID)
	results, err := w.rdb.ZRevRangeWithScores(ctx, lbKey, 0, -1).Result()
	if err != nil {
		return
	}

	playersKey := fmt.Sprintf("room:%s:players", roomID)

	entries := make([]*quizv1.LeaderboardEntry, 0, len(results))
	for i, r := range results {
		userID := r.Member.(string)
		username := userID // fallback
		playerData, err := w.rdb.HGet(ctx, playersKey, userID).Result()
		if err == nil {
			var p struct {
				Username string `json:"username"`
			}
			if json.Unmarshal([]byte(playerData), &p) == nil {
				username = p.Username
			}
		}

		entries = append(entries, &quizv1.LeaderboardEntry{
			UserId:   userID,
			Username: username,
			Score:    int32(r.Score),
			Rank:     int32(i + 1),
		})
	}

	event := &quizv1.GameEvent{
		Event: &quizv1.GameEvent_Leaderboard{
			Leaderboard: &quizv1.LeaderboardUpdate{
				Entries:    entries,
				AfterRound: afterRound,
			},
		},
	}
	w.streamer.BroadcastToRoom(roomID, event)
}

func (w *RoundCompletedWorker) broadcastMatchEnd(ctx context.Context, roomID string) {
	lbKey := fmt.Sprintf("room:%s:leaderboard", roomID)
	results, err := w.rdb.ZRevRangeWithScores(ctx, lbKey, 0, -1).Result()
	if err != nil || len(results) == 0 {
		return
	}

	playersKey := fmt.Sprintf("room:%s:players", roomID)

	standings := make([]*quizv1.FinalStanding, 0, len(results))
	for i, r := range results {
		userID := r.Member.(string)
		username := userID
		playerData, err := w.rdb.HGet(ctx, playersKey, userID).Result()
		if err == nil {
			var p struct {
				Username string `json:"username"`
			}
			if json.Unmarshal([]byte(playerData), &p) == nil {
				username = p.Username
			}
		}

		standings = append(standings, &quizv1.FinalStanding{
			UserId:     userID,
			Username:   username,
			FinalScore: int32(r.Score),
			Rank:       int32(i + 1),
		})
	}

	winnerID := results[0].Member.(string)
	winnerName := standings[0].Username

	event := &quizv1.GameEvent{
		Event: &quizv1.GameEvent_MatchEnd{
			MatchEnd: &quizv1.MatchEnd{
				RoomId:         roomID,
				WinnerUserId:   winnerID,
				WinnerUsername: winnerName,
				Standings:      standings,
			},
		},
	}
	w.streamer.BroadcastToRoom(roomID, event)
}

func timeAfter(seconds int) <-chan time.Time {
	return time.After(time.Duration(seconds) * time.Second)
}
