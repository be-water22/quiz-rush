package matchmaking

import (
	"context"
	"log"
	"time"

	"github.com/google/uuid"
	matchmakingv1 "github.com/quizbattle/server/gen/matchmaking/v1"
	"google.golang.org/grpc"
)

type Server struct {
	matchmakingv1.UnimplementedMatchmakingServiceServer
	pool     *Pool
	streamer *Streamer
}

func NewServer(pool *Pool, streamer *Streamer) *Server {
	return &Server{
		pool:     pool,
		streamer: streamer,
	}
}

func (s *Server) Register(srv *grpc.Server) {
	matchmakingv1.RegisterMatchmakingServiceServer(srv, s)
}

func (s *Server) JoinMatchmaking(ctx context.Context, req *matchmakingv1.JoinRequest) (*matchmakingv1.JoinResponse, error) {
	ticketID := uuid.New().String()

	entry := PoolEntry{
		UserID:   req.UserId,
		Username: req.Username,
		Rating:   req.Rating,
		JoinedAt: time.Now(),
	}

	if err := s.pool.Add(ctx, entry); err != nil {
		return nil, err
	}

	poolSize, _ := s.pool.Size(ctx)

	log.Printf("Player joined matchmaking: %s (%s) rating=%d", req.Username, req.UserId, req.Rating)

	return &matchmakingv1.JoinResponse{
		TicketId:          ticketID,
		EstimatedWaitSecs: 15,
		PoolSize:          int32(poolSize),
	}, nil
}

func (s *Server) LeaveMatchmaking(ctx context.Context, req *matchmakingv1.LeaveRequest) (*matchmakingv1.LeaveResponse, error) {
	if err := s.pool.Remove(ctx, req.UserId); err != nil {
		return nil, err
	}
	s.streamer.Unregister(req.UserId)

	log.Printf("Player left matchmaking: %s", req.UserId)

	return &matchmakingv1.LeaveResponse{Success: true}, nil
}

func (s *Server) SubscribeToMatch(req *matchmakingv1.SubscribeRequest, stream matchmakingv1.MatchmakingService_SubscribeToMatchServer) error {
	ch := s.streamer.Register(req.UserId)
	defer s.streamer.Unregister(req.UserId)

	log.Printf("Player subscribed to match events: %s", req.UserId)

	for {
		select {
		case <-stream.Context().Done():
			return nil
		case event, ok := <-ch:
			if !ok {
				return nil
			}
			if err := stream.Send(event); err != nil {
				return err
			}
		}
	}
}
