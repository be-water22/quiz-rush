package quizengine

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"sync"
	"time"

	"github.com/quizbattle/server/internal/models"
	"github.com/quizbattle/server/internal/rabbitmq"
	"github.com/redis/go-redis/v9"
	"google.golang.org/protobuf/types/known/timestamppb"

	quizv1 "github.com/quizbattle/server/gen/quiz/v1"
)

const (
	questionTimeLimitSecs = 15
)

type RoundCompletedEvent struct {
	RoomID string `json:"roomId"`
	Round  int32  `json:"round"`
}

type MatchFinishedEvent struct {
	RoomID string `json:"roomId"`
}

type RoundManager struct {
	rdb       *redis.Client
	publisher *rabbitmq.Publisher
	streamer  *GameStreamer
	mu        sync.Mutex
	timers    map[string]*time.Timer // roomID -> round timer
}

func NewRoundManager(rdb *redis.Client, publisher *rabbitmq.Publisher, streamer *GameStreamer) *RoundManager {
	return &RoundManager{
		rdb:       rdb,
		publisher: publisher,
		streamer:  streamer,
		timers:    make(map[string]*time.Timer),
	}
}

func (rm *RoundManager) StartRound(ctx context.Context, roomID string, round int32, question models.Question) {
	// Set current round in Redis
	roundKey := fmt.Sprintf("room:%s:round", roomID)
	rm.rdb.Set(ctx, roundKey, round, 30*time.Minute)

	// Broadcast question to all players
	deadline := time.Now().Add(time.Duration(questionTimeLimitSecs) * time.Second)
	event := &quizv1.GameEvent{
		Event: &quizv1.GameEvent_Question{
			Question: &quizv1.QuestionBroadcast{
				Round:         round,
				QuestionId:    question.ID.Hex(),
				Text:          question.Text,
				Options:       question.Options,
				Difficulty:    question.Difficulty,
				TimeLimitSecs: questionTimeLimitSecs,
				Deadline:      timestamppb.New(deadline),
			},
		},
	}
	rm.streamer.BroadcastToRoom(roomID, event)

	// Start timer for this round
	rm.mu.Lock()
	if timer, exists := rm.timers[roomID]; exists {
		timer.Stop()
	}
	rm.timers[roomID] = time.AfterFunc(time.Duration(questionTimeLimitSecs)*time.Second, func() {
		rm.onRoundTimeout(roomID, round)
	})
	rm.mu.Unlock()

	// Start timer sync goroutine
	go rm.syncTimer(ctx, roomID, round, deadline)

	log.Printf("Round %d started for room %s: %s", round, roomID, question.Text)
}

func (rm *RoundManager) syncTimer(ctx context.Context, roomID string, round int32, deadline time.Time) {
	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			return
		case <-ticker.C:
			remaining := time.Until(deadline)
			if remaining <= 0 {
				return
			}
			event := &quizv1.GameEvent{
				Event: &quizv1.GameEvent_TimerSync{
					TimerSync: &quizv1.TimerSync{
						Round:         round,
						RemainingSecs: int32(remaining.Seconds()),
						ServerTime:    timestamppb.Now(),
					},
				},
			}
			rm.streamer.BroadcastToRoom(roomID, event)
		}
	}
}

func (rm *RoundManager) onRoundTimeout(roomID string, round int32) {
	ctx := context.Background()
	event := RoundCompletedEvent{
		RoomID: roomID,
		Round:  round,
	}
	if err := rm.publisher.Publish(ctx, "round.completed", event); err != nil {
		log.Printf("Failed to publish round.completed: %v", err)
	}
}

func (rm *RoundManager) CheckAllAnswered(ctx context.Context, roomID string, round int32) (bool, error) {
	answersKey := fmt.Sprintf("room:%s:answers:%d", roomID, round)
	playersKey := fmt.Sprintf("room:%s:players", roomID)

	answerCount, err := rm.rdb.HLen(ctx, answersKey).Result()
	if err != nil {
		return false, err
	}

	playerCount, err := rm.rdb.HLen(ctx, playersKey).Result()
	if err != nil {
		return false, err
	}

	return answerCount >= playerCount, nil
}

func (rm *RoundManager) CompleteRound(ctx context.Context, roomID string, round int32) {
	// Stop the timer
	rm.mu.Lock()
	if timer, exists := rm.timers[roomID]; exists {
		timer.Stop()
		delete(rm.timers, roomID)
	}
	rm.mu.Unlock()

	// Publish round.completed
	event := RoundCompletedEvent{
		RoomID: roomID,
		Round:  round,
	}
	if err := rm.publisher.Publish(ctx, "round.completed", event); err != nil {
		log.Printf("Failed to publish round.completed: %v", err)
	}
}

func (rm *RoundManager) FinishMatch(ctx context.Context, roomID string) {
	event := MatchFinishedEvent{RoomID: roomID}
	if err := rm.publisher.Publish(ctx, "match.finished", event); err != nil {
		log.Printf("Failed to publish match.finished: %v", err)
	}
}

type AnswerData struct {
	UserID        string `json:"userId"`
	QuestionID    string `json:"questionId"`
	SelectedIndex int32  `json:"selectedIndex"`
	ResponseTime  int64  `json:"responseTimeMs"`
	Correct       bool   `json:"correct"`
}

func (rm *RoundManager) StoreAnswer(ctx context.Context, roomID string, round int32, answer AnswerData) (bool, error) {
	answersKey := fmt.Sprintf("room:%s:answers:%d", roomID, round)
	data, _ := json.Marshal(answer)

	// HSETNX returns true if the field was set (first time)
	set, err := rm.rdb.HSetNX(ctx, answersKey, answer.UserID, data).Result()
	if err != nil {
		return false, err
	}

	if set {
		rm.rdb.Expire(ctx, answersKey, 30*time.Minute)
	}

	return set, nil
}
