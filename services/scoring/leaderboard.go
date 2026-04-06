package scoring

import (
	"context"
	_ "embed"
	"fmt"

	"github.com/redis/go-redis/v9"
)

//go:embed ../../internal/lua/leaderboard_update.lua
var leaderboardUpdateScript string

type Leaderboard struct {
	rdb *redis.Client
}

func NewLeaderboard(rdb *redis.Client) *Leaderboard {
	return &Leaderboard{rdb: rdb}
}

// UpdateScore atomically increments a player's score and returns new total and rank
func (lb *Leaderboard) UpdateScore(ctx context.Context, roomID, userID string, points int32) (int32, int32, error) {
	key := fmt.Sprintf("room:%s:leaderboard", roomID)

	result, err := lb.rdb.Eval(ctx, leaderboardUpdateScript, []string{key}, userID, points).Int64Slice()
	if err != nil {
		return 0, 0, err
	}

	totalScore := int32(result[0])
	rank := int32(result[1]) + 1 // Convert 0-based to 1-based

	return totalScore, rank, nil
}

// GetAll returns all leaderboard entries sorted by score descending
func (lb *Leaderboard) GetAll(ctx context.Context, roomID string) ([]LeaderboardEntry, error) {
	key := fmt.Sprintf("room:%s:leaderboard", roomID)
	results, err := lb.rdb.ZRevRangeWithScores(ctx, key, 0, -1).Result()
	if err != nil {
		return nil, err
	}

	entries := make([]LeaderboardEntry, len(results))
	for i, r := range results {
		entries[i] = LeaderboardEntry{
			UserID: r.Member.(string),
			Score:  int32(r.Score),
			Rank:   int32(i + 1),
		}
	}
	return entries, nil
}

type LeaderboardEntry struct {
	UserID string
	Score  int32
	Rank   int32
}
