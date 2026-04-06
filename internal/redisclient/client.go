package redisclient

import (
	"context"
	"log"

	"github.com/redis/go-redis/v9"
)

func Connect(ctx context.Context, addr string) (*redis.Client, error) {
	rdb := redis.NewClient(&redis.Options{
		Addr: addr,
	})

	if err := rdb.Ping(ctx).Err(); err != nil {
		return nil, err
	}

	log.Printf("Connected to Redis: %s", addr)
	return rdb, nil
}
