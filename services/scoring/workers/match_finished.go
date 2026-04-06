package workers

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/quizbattle/server/internal/models"
	"github.com/quizbattle/server/internal/rabbitmq"
	"github.com/quizbattle/server/services/scoring"
	"github.com/redis/go-redis/v9"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

type MatchFinishedEvent struct {
	RoomID string `json:"roomId"`
}

type MatchFinishedWorker struct {
	rdb         *redis.Client
	db          *mongo.Database
	leaderboard *scoring.Leaderboard
}

func NewMatchFinishedWorker(rdb *redis.Client, db *mongo.Database) *MatchFinishedWorker {
	return &MatchFinishedWorker{
		rdb:         rdb,
		db:          db,
		leaderboard: scoring.NewLeaderboard(rdb),
	}
}

func (w *MatchFinishedWorker) Start(ctx context.Context, rmqConn *rabbitmq.Connection) error {
	consumer, err := rabbitmq.NewConsumer(rmqConn, "match-finished-queue", "match.finished", w.handle)
	if err != nil {
		return err
	}
	return consumer.Start(ctx)
}

func (w *MatchFinishedWorker) handle(ctx context.Context, body []byte) error {
	var event MatchFinishedEvent
	if err := json.Unmarshal(body, &event); err != nil {
		return err
	}

	log.Printf("Processing match.finished: room=%s", event.RoomID)

	// Get final leaderboard
	entries, err := w.leaderboard.GetAll(ctx, event.RoomID)
	if err != nil {
		return fmt.Errorf("failed to get leaderboard: %w", err)
	}

	// Get player data
	playersKey := fmt.Sprintf("room:%s:players", event.RoomID)
	playerData, err := w.rdb.HGetAll(ctx, playersKey).Result()
	if err != nil {
		return fmt.Errorf("failed to get players: %w", err)
	}

	// Build match players
	matchPlayers := make([]models.MatchPlayer, 0, len(entries))
	for _, e := range entries {
		username := e.UserID
		if data, ok := playerData[e.UserID]; ok {
			var p struct {
				Username string `json:"username"`
			}
			if json.Unmarshal([]byte(data), &p) == nil {
				username = p.Username
			}
		}

		matchPlayers = append(matchPlayers, models.MatchPlayer{
			UserID:     e.UserID,
			Username:   username,
			FinalScore: e.Score,
			Rank:       e.Rank,
		})
	}

	// Determine winner
	winner := ""
	if len(matchPlayers) > 0 {
		winner = matchPlayers[0].UserID
	}

	// Get total rounds
	stateKey := fmt.Sprintf("room:%s:state", event.RoomID)
	stateData, _ := w.rdb.Get(ctx, stateKey).Bytes()
	var state struct {
		TotalRounds int32 `json:"totalRounds"`
	}
	json.Unmarshal(stateData, &state)
	if state.TotalRounds == 0 {
		state.TotalRounds = 5
	}

	// Persist to MongoDB
	matchHistory := models.MatchHistory{
		RoomID:    event.RoomID,
		Players:   matchPlayers,
		Rounds:    state.TotalRounds,
		Winner:    winner,
		CreatedAt: time.Now(),
	}

	_, err = w.db.Collection("match_history").InsertOne(ctx, matchHistory)
	if err != nil {
		return fmt.Errorf("failed to persist match history: %w", err)
	}

	// Update user stats
	for _, mp := range matchPlayers {
		filter := bson.M{"username": mp.Username}
		update := bson.M{
			"$inc": bson.M{"matchesPlayed": 1},
		}
		if mp.Rank == 1 {
			update["$inc"].(bson.M)["wins"] = 1
		}
		w.db.Collection("users").UpdateOne(ctx, filter, update)
	}

	log.Printf("Match history persisted: room=%s winner=%s", event.RoomID, winner)
	return nil
}
