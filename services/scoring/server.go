package scoring

import (
	"context"
	"log"

	scoringv1 "github.com/quizbattle/server/gen/scoring/v1"
	"github.com/redis/go-redis/v9"
	"google.golang.org/grpc"
)

type Server struct {
	scoringv1.UnimplementedScoringServiceServer
	rdb         *redis.Client
	leaderboard *Leaderboard
}

func NewServer(rdb *redis.Client) *Server {
	return &Server{
		rdb:         rdb,
		leaderboard: NewLeaderboard(rdb),
	}
}

func (s *Server) Register(srv *grpc.Server) {
	scoringv1.RegisterScoringServiceServer(srv, s)
}

func (s *Server) CalculateScore(ctx context.Context, req *scoringv1.ScoreRequest) (*scoringv1.ScoreResponse, error) {
	points := CalculatePoints(req.Correct, req.Difficulty, req.ResponseTimeMs, req.TimeLimitMs)

	totalScore, newRank, err := s.leaderboard.UpdateScore(ctx, req.RoomId, req.UserId, points)
	if err != nil {
		return nil, err
	}

	log.Printf("Score calculated: room=%s user=%s points=%d total=%d rank=%d",
		req.RoomId, req.UserId, points, totalScore, newRank)

	return &scoringv1.ScoreResponse{
		PointsAwarded: points,
		TotalScore:    totalScore,
		NewRank:       newRank,
	}, nil
}

func (s *Server) GetLeaderboard(ctx context.Context, req *scoringv1.LeaderboardRequest) (*scoringv1.LeaderboardResponse, error) {
	entries, err := s.leaderboard.GetAll(ctx, req.RoomId)
	if err != nil {
		return nil, err
	}

	protoEntries := make([]*scoringv1.LeaderboardEntry, len(entries))
	for i, e := range entries {
		protoEntries[i] = &scoringv1.LeaderboardEntry{
			UserId: e.UserID,
			Score:  e.Score,
			Rank:   e.Rank,
		}
	}

	return &scoringv1.LeaderboardResponse{Entries: protoEntries}, nil
}
