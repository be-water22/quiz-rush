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
)

type MatchCreatedEvent struct {
	RoomID      string `json:"roomId"`
	Players     []struct {
		UserID   string `json:"userId"`
		Username string `json:"username"`
		Rating   int32  `json:"rating"`
	} `json:"players"`
	TotalRounds int32 `json:"totalRounds"`
}

type MatchCreatedWorker struct {
	selector     *quizengine.QuestionSelector
	roundManager *quizengine.RoundManager
	rdb          *redis.Client
}

func NewMatchCreatedWorker(db *mongo.Database, rdb *redis.Client, roundManager *quizengine.RoundManager) *MatchCreatedWorker {
	return &MatchCreatedWorker{
		selector:     quizengine.NewQuestionSelector(db),
		roundManager: roundManager,
		rdb:          rdb,
	}
}

func (w *MatchCreatedWorker) Start(ctx context.Context, rmqConn *rabbitmq.Connection) error {
	consumer, err := rabbitmq.NewConsumer(rmqConn, "match-created-queue", "match.created", w.handle)
	if err != nil {
		return err
	}
	return consumer.Start(ctx)
}

func (w *MatchCreatedWorker) handle(ctx context.Context, body []byte) error {
	var event MatchCreatedEvent
	if err := json.Unmarshal(body, &event); err != nil {
		return err
	}

	log.Printf("Processing match.created: room=%s rounds=%d", event.RoomID, event.TotalRounds)

	// Select questions for the match
	questions, err := w.selector.SelectForMatch(ctx, event.TotalRounds)
	if err != nil {
		return fmt.Errorf("failed to select questions: %w", err)
	}

	// Store question IDs in Redis
	questionsKey := fmt.Sprintf("room:%s:questions", event.RoomID)
	for _, q := range questions {
		w.rdb.RPush(ctx, questionsKey, q.ID.Hex())
	}
	w.rdb.Expire(ctx, questionsKey, 30*time.Minute)

	// Store question data in Redis for quick access
	for _, q := range questions {
		qKey := fmt.Sprintf("room:%s:question:%s", event.RoomID, q.ID.Hex())
		data, _ := json.Marshal(q)
		w.rdb.Set(ctx, qKey, data, 30*time.Minute)
	}

	// Update room state to in_progress
	stateKey := fmt.Sprintf("room:%s:state", event.RoomID)
	w.rdb.Set(ctx, stateKey, `{"state":"in_progress","totalRounds":`+fmt.Sprintf("%d", event.TotalRounds)+`}`, 30*time.Minute)

	// Start the first round
	if len(questions) > 0 {
		w.roundManager.StartRound(ctx, event.RoomID, 1, questions[0])
	}

	return nil
}

func (w *MatchCreatedWorker) getQuestionForRound(ctx context.Context, roomID string, round int32) (*models.Question, error) {
	qKey := fmt.Sprintf("room:%s:questions", roomID)
	questionID, err := w.rdb.LIndex(ctx, qKey, int64(round-1)).Result()
	if err != nil {
		return nil, err
	}

	// Try to get from cache
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
