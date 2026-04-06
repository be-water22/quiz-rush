package matchmaking

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"github.com/redis/go-redis/v9"
)

const roomTTL = 30 * time.Minute

type RoomState string

const (
	RoomStateWaiting    RoomState = "waiting"
	RoomStateInProgress RoomState = "in_progress"
	RoomStateFinished   RoomState = "finished"
)

type RoomInfo struct {
	RoomID      string    `json:"roomId"`
	State       RoomState `json:"state"`
	TotalRounds int32     `json:"totalRounds"`
	CreatedAt   int64     `json:"createdAt"`
}

type RoomPlayer struct {
	UserID   string `json:"userId"`
	Username string `json:"username"`
	Rating   int32  `json:"rating"`
}

type RoomManager struct {
	rdb *redis.Client
}

func NewRoomManager(rdb *redis.Client) *RoomManager {
	return &RoomManager{rdb: rdb}
}

func (rm *RoomManager) CreateRoom(ctx context.Context, roomID string, players []RoomPlayer, totalRounds int32) error {
	pipe := rm.rdb.Pipeline()

	// Set room state
	info := RoomInfo{
		RoomID:      roomID,
		State:       RoomStateWaiting,
		TotalRounds: totalRounds,
		CreatedAt:   time.Now().Unix(),
	}
	stateJSON, _ := json.Marshal(info)
	stateKey := fmt.Sprintf("room:%s:state", roomID)
	pipe.Set(ctx, stateKey, stateJSON, roomTTL)

	// Set room players
	playersKey := fmt.Sprintf("room:%s:players", roomID)
	for _, p := range players {
		playerJSON, _ := json.Marshal(p)
		pipe.HSet(ctx, playersKey, p.UserID, playerJSON)
	}
	pipe.Expire(ctx, playersKey, roomTTL)

	// Set initial round
	roundKey := fmt.Sprintf("room:%s:round", roomID)
	pipe.Set(ctx, roundKey, "0", roomTTL)

	// Initialize leaderboard
	lbKey := fmt.Sprintf("room:%s:leaderboard", roomID)
	for _, p := range players {
		pipe.ZAdd(ctx, lbKey, redis.Z{Score: 0, Member: p.UserID})
	}
	pipe.Expire(ctx, lbKey, roomTTL)

	_, err := pipe.Exec(ctx)
	return err
}

func (rm *RoomManager) GetState(ctx context.Context, roomID string) (*RoomInfo, error) {
	stateKey := fmt.Sprintf("room:%s:state", roomID)
	data, err := rm.rdb.Get(ctx, stateKey).Bytes()
	if err != nil {
		return nil, err
	}
	var info RoomInfo
	if err := json.Unmarshal(data, &info); err != nil {
		return nil, err
	}
	return &info, nil
}

func (rm *RoomManager) SetState(ctx context.Context, roomID string, state RoomState) error {
	info, err := rm.GetState(ctx, roomID)
	if err != nil {
		return err
	}
	info.State = state
	stateJSON, _ := json.Marshal(info)
	stateKey := fmt.Sprintf("room:%s:state", roomID)
	return rm.rdb.Set(ctx, stateKey, stateJSON, roomTTL).Err()
}

func (rm *RoomManager) GetPlayers(ctx context.Context, roomID string) ([]RoomPlayer, error) {
	playersKey := fmt.Sprintf("room:%s:players", roomID)
	data, err := rm.rdb.HGetAll(ctx, playersKey).Result()
	if err != nil {
		return nil, err
	}

	players := make([]RoomPlayer, 0, len(data))
	for _, v := range data {
		var p RoomPlayer
		if err := json.Unmarshal([]byte(v), &p); err != nil {
			continue
		}
		players = append(players, p)
	}
	return players, nil
}

func (rm *RoomManager) GetCurrentRound(ctx context.Context, roomID string) (int32, error) {
	roundKey := fmt.Sprintf("room:%s:round", roomID)
	val, err := rm.rdb.Get(ctx, roundKey).Int()
	if err != nil {
		return 0, err
	}
	return int32(val), nil
}

func (rm *RoomManager) SetCurrentRound(ctx context.Context, roomID string, round int32) error {
	roundKey := fmt.Sprintf("room:%s:round", roomID)
	return rm.rdb.Set(ctx, roundKey, round, roomTTL).Err()
}
