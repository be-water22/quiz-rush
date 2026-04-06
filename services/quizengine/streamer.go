package quizengine

import (
	"sync"

	quizv1 "github.com/quizbattle/server/gen/quiz/v1"
)

type GameStreamer struct {
	mu      sync.RWMutex
	// roomID -> map[userID -> channel]
	streams map[string]map[string]chan *quizv1.GameEvent
}

func NewGameStreamer() *GameStreamer {
	return &GameStreamer{
		streams: make(map[string]map[string]chan *quizv1.GameEvent),
	}
}

func (gs *GameStreamer) Register(roomID, userID string) chan *quizv1.GameEvent {
	gs.mu.Lock()
	defer gs.mu.Unlock()

	if gs.streams[roomID] == nil {
		gs.streams[roomID] = make(map[string]chan *quizv1.GameEvent)
	}

	ch := make(chan *quizv1.GameEvent, 20)
	gs.streams[roomID][userID] = ch
	return ch
}

func (gs *GameStreamer) Unregister(roomID, userID string) {
	gs.mu.Lock()
	defer gs.mu.Unlock()

	if room, ok := gs.streams[roomID]; ok {
		if ch, ok := room[userID]; ok {
			close(ch)
			delete(room, userID)
		}
		if len(room) == 0 {
			delete(gs.streams, roomID)
		}
	}
}

func (gs *GameStreamer) BroadcastToRoom(roomID string, event *quizv1.GameEvent) {
	gs.mu.RLock()
	defer gs.mu.RUnlock()

	if room, ok := gs.streams[roomID]; ok {
		for _, ch := range room {
			select {
			case ch <- event:
			default:
			}
		}
	}
}

func (gs *GameStreamer) SendToPlayer(roomID, userID string, event *quizv1.GameEvent) {
	gs.mu.RLock()
	defer gs.mu.RUnlock()

	if room, ok := gs.streams[roomID]; ok {
		if ch, ok := room[userID]; ok {
			select {
			case ch <- event:
			default:
			}
		}
	}
}
