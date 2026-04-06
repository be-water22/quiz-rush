package workers

import (
	"context"
	"encoding/json"
	"fmt"
	"log"

	"github.com/quizbattle/server/internal/rabbitmq"
	"github.com/quizbattle/server/services/scoring"
	"github.com/redis/go-redis/v9"
)

type AnswerSubmittedEvent struct {
	RoomID       string `json:"roomId"`
	UserID       string `json:"userId"`
	QuestionID   string `json:"questionId"`
	Round        int32  `json:"round"`
	Correct      bool   `json:"correct"`
	ResponseTime int64  `json:"responseTimeMs"`
	Difficulty   string `json:"difficulty"`
	TimeLimitMs  int32  `json:"timeLimitMs"`
}

type AnswerWorker struct {
	rdb         *redis.Client
	leaderboard *scoring.Leaderboard
}

func NewAnswerWorker(rdb *redis.Client) *AnswerWorker {
	return &AnswerWorker{
		rdb:         rdb,
		leaderboard: scoring.NewLeaderboard(rdb),
	}
}

func (w *AnswerWorker) Start(ctx context.Context, rmqConn *rabbitmq.Connection) error {
	consumer, err := rabbitmq.NewConsumer(rmqConn, "answer-processing-queue", "answer.submitted", w.handle)
	if err != nil {
		return err
	}
	return consumer.Start(ctx)
}

func (w *AnswerWorker) handle(ctx context.Context, body []byte) error {
	var event AnswerSubmittedEvent
	if err := json.Unmarshal(body, &event); err != nil {
		return err
	}

	// Idempotency check
	idempotencyKey := fmt.Sprintf("room:%s:scored:%d", event.RoomID, event.Round)
	isNew, err := w.rdb.HSetNX(ctx, idempotencyKey, event.UserID, "1").Result()
	if err != nil {
		return err
	}
	if !isNew {
		log.Printf("Answer already scored: room=%s user=%s round=%d (skipping)", event.RoomID, event.UserID, event.Round)
		return nil // Already processed
	}

	// Calculate score
	points := scoring.CalculatePoints(event.Correct, event.Difficulty, event.ResponseTime, event.TimeLimitMs)

	// Update leaderboard atomically
	totalScore, newRank, err := w.leaderboard.UpdateScore(ctx, event.RoomID, event.UserID, points)
	if err != nil {
		return err
	}

	log.Printf("Answer scored: room=%s user=%s round=%d correct=%v points=%d total=%d rank=%d",
		event.RoomID, event.UserID, event.Round, event.Correct, points, totalScore, newRank)

	return nil
}
