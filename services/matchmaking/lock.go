package matchmaking

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

type Lock struct {
	rdb *redis.Client
}

func NewLock(rdb *redis.Client) *Lock {
	return &Lock{rdb: rdb}
}

func (l *Lock) Acquire(ctx context.Context, key string, ttl time.Duration) (string, bool, error) {
	val := uuid.New().String()
	ok, err := l.rdb.SetNX(ctx, key, val, ttl).Result()
	if err != nil {
		return "", false, err
	}
	return val, ok, nil
}

func (l *Lock) Release(ctx context.Context, key, val string) error {
	script := `if redis.call("get", KEYS[1]) == ARGV[1] then return redis.call("del", KEYS[1]) else return 0 end`
	return l.rdb.Eval(ctx, script, []string{key}, val).Err()
}
