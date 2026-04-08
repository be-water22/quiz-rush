package matchmaking

import (
	"context"
	"fmt"
	"time"

	"github.com/redis/go-redis/v9"
)

var matchmakingPopScript = `
local removed = {}
for i, uid in ipairs(ARGV) do
  local result = redis.call('ZREM', KEYS[1], uid)
  if result == 1 then
    table.insert(removed, uid)
  end
end
return removed
`

const poolKey = "matchmaking:pool"

type PoolEntry struct {
	UserID   string
	Username string
	Rating   int32
	JoinedAt time.Time
}

type Pool struct {
	rdb *redis.Client
}

func NewPool(rdb *redis.Client) *Pool {
	return &Pool{rdb: rdb}
}

func (p *Pool) Add(ctx context.Context, entry PoolEntry) error {
	// Store player data in a hash
	dataKey := fmt.Sprintf("matchmaking:player:%s", entry.UserID)
	pipe := p.rdb.Pipeline()
	pipe.ZAdd(ctx, poolKey, redis.Z{
		Score:  float64(entry.Rating),
		Member: entry.UserID,
	})
	pipe.HSet(ctx, dataKey, map[string]interface{}{
		"username": entry.Username,
		"rating":   entry.Rating,
		"joinedAt": entry.JoinedAt.Unix(),
	})
	pipe.Expire(ctx, dataKey, 5*time.Minute)
	_, err := pipe.Exec(ctx)
	return err
}

func (p *Pool) Remove(ctx context.Context, userID string) error {
	pipe := p.rdb.Pipeline()
	pipe.ZRem(ctx, poolKey, userID)
	pipe.Del(ctx, fmt.Sprintf("matchmaking:player:%s", userID))
	_, err := pipe.Exec(ctx)
	return err
}

func (p *Pool) GetAll(ctx context.Context) ([]PoolEntry, error) {
	members, err := p.rdb.ZRangeWithScores(ctx, poolKey, 0, -1).Result()
	if err != nil {
		return nil, err
	}

	entries := make([]PoolEntry, 0, len(members))
	for _, m := range members {
		userID := m.Member.(string)
		dataKey := fmt.Sprintf("matchmaking:player:%s", userID)
		data, err := p.rdb.HGetAll(ctx, dataKey).Result()
		if err != nil || len(data) == 0 {
			continue
		}
		entries = append(entries, PoolEntry{
			UserID:   userID,
			Username: data["username"],
			Rating:   int32(m.Score),
		})
	}
	return entries, nil
}

func (p *Pool) Size(ctx context.Context) (int64, error) {
	return p.rdb.ZCard(ctx, poolKey).Result()
}

// AtomicRemove removes multiple players from the pool atomically using Lua
func (p *Pool) AtomicRemove(ctx context.Context, userIDs []string) ([]string, error) {
	args := make([]interface{}, len(userIDs))
	for i, id := range userIDs {
		args[i] = id
	}

	result, err := p.rdb.Eval(ctx, matchmakingPopScript, []string{poolKey}, args...).StringSlice()
	if err != nil {
		return nil, err
	}
	return result, nil
}
