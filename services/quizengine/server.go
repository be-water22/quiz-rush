package quizengine

import (
	"context"
	"encoding/json"
	"fmt"
	"log"

	quizv1 "github.com/quizbattle/server/gen/quiz/v1"
	"github.com/quizbattle/server/internal/rabbitmq"
	"github.com/redis/go-redis/v9"
	"go.mongodb.org/mongo-driver/mongo"
	"google.golang.org/grpc"
)

type Server struct {
	quizv1.UnimplementedQuizServiceServer
	rdb          *redis.Client
	db           *mongo.Database
	streamer     *GameStreamer
	roundManager *RoundManager
	publisher    *rabbitmq.Publisher
	selector     *QuestionSelector
}

func NewServer(rdb *redis.Client, db *mongo.Database, streamer *GameStreamer, roundManager *RoundManager, publisher *rabbitmq.Publisher) *Server {
	return &Server{
		rdb:          rdb,
		db:           db,
		streamer:     streamer,
		roundManager: roundManager,
		publisher:    publisher,
		selector:     NewQuestionSelector(db),
	}
}

func (s *Server) Register(srv *grpc.Server) {
	quizv1.RegisterQuizServiceServer(srv, s)
}

func (s *Server) GetRoomQuestions(ctx context.Context, req *quizv1.RoomRequest) (*quizv1.QuestionsResponse, error) {
	questionsKey := fmt.Sprintf("room:%s:questions", req.RoomId)
	questionIDs, err := s.rdb.LRange(ctx, questionsKey, 0, -1).Result()
	if err != nil {
		return nil, err
	}

	questions := make([]*quizv1.Question, 0, len(questionIDs))
	for _, qid := range questionIDs {
		cacheKey := fmt.Sprintf("room:%s:question:%s", req.RoomId, qid)
		data, err := s.rdb.Get(ctx, cacheKey).Bytes()
		if err != nil {
			continue
		}
		var q struct {
			Text       string   `json:"text"`
			Options    []string `json:"options"`
			Difficulty string   `json:"difficulty"`
			Topic      string   `json:"topic"`
		}
		if json.Unmarshal(data, &q) == nil {
			questions = append(questions, &quizv1.Question{
				QuestionId:    qid,
				Text:          q.Text,
				Options:       q.Options,
				Difficulty:    q.Difficulty,
				Topic:         q.Topic,
				TimeLimitSecs: questionTimeLimitSecs,
			})
		}
	}

	return &quizv1.QuestionsResponse{Questions: questions}, nil
}

type AnswerSubmittedEvent struct {
	RoomID       string `json:"roomId"`
	UserID       string `json:"userId"`
	QuestionID   string `json:"questionId"`
	Round        int32  `json:"round"`
	Correct      bool   `json:"correct"`
	ResponseTime int64  `json:"responseTimeMs"`
	Difficulty   string `json:"difficulty"`
	TimeLimitMs  int32  `json:"timeLimitMs"`
}

func (s *Server) SubmitAnswer(ctx context.Context, req *quizv1.AnswerRequest) (*quizv1.AnswerAck, error) {
	// Validate round
	roundKey := fmt.Sprintf("room:%s:round", req.RoomId)
	currentRound, err := s.rdb.Get(ctx, roundKey).Int()
	if err != nil {
		return &quizv1.AnswerAck{Accepted: false, Reason: "invalid_room"}, nil
	}
	if int32(currentRound) != req.Round {
		return &quizv1.AnswerAck{Accepted: false, Reason: "invalid_round"}, nil
	}

	// Get question to check correctness
	cacheKey := fmt.Sprintf("room:%s:question:%s", req.RoomId, req.QuestionId)
	data, err := s.rdb.Get(ctx, cacheKey).Bytes()
	if err != nil {
		return &quizv1.AnswerAck{Accepted: false, Reason: "question_not_found"}, nil
	}

	var question struct {
		CorrectIndex int32  `json:"correctIndex"`
		Difficulty   string `json:"difficulty"`
	}
	json.Unmarshal(data, &question)

	correct := req.SelectedIndex == question.CorrectIndex

	// Store answer (HSETNX for idempotency)
	answer := AnswerData{
		UserID:        req.UserId,
		QuestionID:    req.QuestionId,
		SelectedIndex: req.SelectedIndex,
		ResponseTime:  req.ResponseTimeMs,
		Correct:       correct,
	}
	isNew, err := s.roundManager.StoreAnswer(ctx, req.RoomId, req.Round, answer)
	if err != nil {
		return nil, err
	}
	if !isNew {
		return &quizv1.AnswerAck{Accepted: false, Reason: "already_answered"}, nil
	}

	// Publish answer.submitted to scoring
	event := AnswerSubmittedEvent{
		RoomID:       req.RoomId,
		UserID:       req.UserId,
		QuestionID:   req.QuestionId,
		Round:        req.Round,
		Correct:      correct,
		ResponseTime: req.ResponseTimeMs,
		Difficulty:   question.Difficulty,
		TimeLimitMs:  questionTimeLimitSecs * 1000,
	}
	if err := s.publisher.Publish(ctx, "answer.submitted", event); err != nil {
		log.Printf("Failed to publish answer.submitted: %v", err)
	}

	// Check if all players have answered
	allAnswered, _ := s.roundManager.CheckAllAnswered(ctx, req.RoomId, req.Round)
	if allAnswered {
		s.roundManager.CompleteRound(ctx, req.RoomId, req.Round)
	}

	return &quizv1.AnswerAck{Accepted: true, Reason: "ok"}, nil
}

func (s *Server) StreamGameEvents(req *quizv1.StreamRequest, stream quizv1.QuizService_StreamGameEventsServer) error {
	ch := s.streamer.Register(req.RoomId, req.UserId)
	defer s.streamer.Unregister(req.RoomId, req.UserId)

	log.Printf("Player %s subscribed to game events for room %s", req.UserId, req.RoomId)

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
