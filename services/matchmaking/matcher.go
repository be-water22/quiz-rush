package matchmaking

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/google/uuid"
	matchmakingv1 "github.com/quizbattle/server/gen/matchmaking/v1"
	"github.com/quizbattle/server/internal/rabbitmq"
)

const (
	defaultTotalRounds = 5
	minPlayers         = 2
	maxPlayers         = 10
	ratingBucketSize   = 200
	maxWaitSeconds     = 30
)

type MatchCreatedEvent struct {
	RoomID      string       `json:"roomId"`
	Players     []RoomPlayer `json:"players"`
	TotalRounds int32        `json:"totalRounds"`
}

type Matcher struct {
	pool      *Pool
	room      *RoomManager
	lock      *Lock
	streamer  *Streamer
	publisher *rabbitmq.Publisher
}

func NewMatcher(pool *Pool, room *RoomManager, lock *Lock, streamer *Streamer, publisher *rabbitmq.Publisher) *Matcher {
	return &Matcher{
		pool:      pool,
		room:      room,
		lock:      lock,
		streamer:  streamer,
		publisher: publisher,
	}
}

func (m *Matcher) Start(ctx context.Context) {
	ticker := time.NewTicker(1 * time.Second)
	defer ticker.Stop()

	log.Println("Matcher started")

	for {
		select {
		case <-ctx.Done():
			return
		case <-ticker.C:
			m.tick(ctx)
		}
	}
}

func (m *Matcher) tick(ctx context.Context) {
	entries, err := m.pool.GetAll(ctx)
	if err != nil {
		log.Printf("Matcher: failed to get pool: %v", err)
		return
	}

	if len(entries) < minPlayers {
		// Broadcast wait update
		poolSize, _ := m.pool.Size(ctx)
		m.streamer.BroadcastWaitUpdate(int32(poolSize), 15)
		return
	}

	// Group by rating buckets
	buckets := make(map[int32][]PoolEntry)
	for _, e := range entries {
		bucketKey := (e.Rating / int32(ratingBucketSize)) * int32(ratingBucketSize)
		buckets[bucketKey] = append(buckets[bucketKey], e)
	}

	// Form matches from buckets with enough players
	for _, bucket := range buckets {
		if len(bucket) >= minPlayers {
			groupSize := len(bucket)
			if groupSize > maxPlayers {
				groupSize = maxPlayers
			}
			group := bucket[:groupSize]
			m.createMatch(ctx, group)
		}
	}

	// Handle timeout: players waiting too long get matched with anyone
	// (simplified: if pool still has >= 2 after bucket matching, force match)
	remaining, _ := m.pool.GetAll(ctx)
	if len(remaining) >= minPlayers {
		groupSize := len(remaining)
		if groupSize > maxPlayers {
			groupSize = maxPlayers
		}
		m.createMatch(ctx, remaining[:groupSize])
	}
}

func (m *Matcher) createMatch(ctx context.Context, entries []PoolEntry) {
	roomID := uuid.New().String()
	lockKey := fmt.Sprintf("room:lock:%s", roomID)

	// Acquire lock
	lockVal, acquired, err := m.lock.Acquire(ctx, lockKey, 10*time.Second)
	if err != nil || !acquired {
		return
	}
	defer m.lock.Release(ctx, lockKey, lockVal)

	// Atomically remove players from pool
	userIDs := make([]string, len(entries))
	for i, e := range entries {
		userIDs[i] = e.UserID
	}
	removed, err := m.pool.AtomicRemove(ctx, userIDs)
	if err != nil || len(removed) < minPlayers {
		return
	}

	// Build room players from actually removed entries
	players := make([]RoomPlayer, 0, len(removed))
	removedSet := make(map[string]bool)
	for _, id := range removed {
		removedSet[id] = true
	}
	for _, e := range entries {
		if removedSet[e.UserID] {
			players = append(players, RoomPlayer{
				UserID:   e.UserID,
				Username: e.Username,
				Rating:   e.Rating,
			})
		}
	}

	// Create room in Redis
	if err := m.room.CreateRoom(ctx, roomID, players, defaultTotalRounds); err != nil {
		log.Printf("Matcher: failed to create room: %v", err)
		return
	}

	// Publish match.created event
	event := MatchCreatedEvent{
		RoomID:      roomID,
		Players:     players,
		TotalRounds: defaultTotalRounds,
	}
	if err := m.publisher.Publish(ctx, "match.created", event); err != nil {
		log.Printf("Matcher: failed to publish match.created: %v", err)
	}

	// Notify waiting streams
	playerInfos := make([]*matchmakingv1.PlayerInfo, len(players))
	for i, p := range players {
		playerInfos[i] = &matchmakingv1.PlayerInfo{
			UserId:   p.UserID,
			Username: p.Username,
			Rating:   p.Rating,
		}
	}

	matchEvent := &matchmakingv1.MatchEvent{
		Event: &matchmakingv1.MatchEvent_MatchFound{
			MatchFound: &matchmakingv1.MatchFound{
				RoomId:      roomID,
				Players:     playerInfos,
				TotalRounds: defaultTotalRounds,
			},
		},
	}

	for _, p := range players {
		m.streamer.Send(p.UserID, matchEvent)
	}

	log.Printf("Match created: room=%s players=%d", roomID, len(players))
}
