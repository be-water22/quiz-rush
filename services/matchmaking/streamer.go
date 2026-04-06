package matchmaking

import (
	"sync"

	matchmakingv1 "github.com/quizbattle/server/gen/matchmaking/v1"
)

type Streamer struct {
	mu       sync.RWMutex
	streams  map[string]chan *matchmakingv1.MatchEvent // userID -> event channel
}

func NewStreamer() *Streamer {
	return &Streamer{
		streams: make(map[string]chan *matchmakingv1.MatchEvent),
	}
}

func (s *Streamer) Register(userID string) chan *matchmakingv1.MatchEvent {
	s.mu.Lock()
	defer s.mu.Unlock()

	ch := make(chan *matchmakingv1.MatchEvent, 10)
	s.streams[userID] = ch
	return ch
}

func (s *Streamer) Unregister(userID string) {
	s.mu.Lock()
	defer s.mu.Unlock()

	if ch, ok := s.streams[userID]; ok {
		close(ch)
		delete(s.streams, userID)
	}
}

func (s *Streamer) Send(userID string, event *matchmakingv1.MatchEvent) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	if ch, ok := s.streams[userID]; ok {
		select {
		case ch <- event:
		default:
			// Channel full, skip
		}
	}
}

func (s *Streamer) SendToMany(userIDs []string, event *matchmakingv1.MatchEvent) {
	for _, id := range userIDs {
		s.Send(id, event)
	}
}

func (s *Streamer) BroadcastWaitUpdate(poolSize int32, eta int32) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	event := &matchmakingv1.MatchEvent{
		Event: &matchmakingv1.MatchEvent_WaitUpdate{
			WaitUpdate: &matchmakingv1.WaitUpdate{
				PoolSize:          poolSize,
				EstimatedWaitSecs: eta,
			},
		},
	}

	for _, ch := range s.streams {
		select {
		case ch <- event:
		default:
		}
	}
}
