package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"
	"os/signal"
	"syscall"

	"github.com/quizbattle/server/internal/config"
	"github.com/quizbattle/server/internal/mongodb"
	"github.com/quizbattle/server/internal/rabbitmq"
	"github.com/quizbattle/server/internal/redisclient"
	"github.com/quizbattle/server/services/quizengine"
	"github.com/quizbattle/server/services/quizengine/workers"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	cfg := config.Load()
	cfg.GRPCPort = getEnvOrDefault("GRPC_PORT", "50052")
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// Connect to Redis
	rdb, err := redisclient.Connect(ctx, cfg.RedisAddr)
	if err != nil {
		log.Fatalf("Failed to connect to Redis: %v", err)
	}
	defer rdb.Close()

	// Connect to MongoDB
	db, err := mongodb.Connect(ctx, cfg.MongoURI, cfg.MongoDB)
	if err != nil {
		log.Fatalf("Failed to connect to MongoDB: %v", err)
	}

	// Connect to RabbitMQ
	rmqConn, err := rabbitmq.NewConnection(cfg.RabbitMQURL)
	if err != nil {
		log.Fatalf("Failed to connect to RabbitMQ: %v", err)
	}
	defer rmqConn.Close()

	// Initialize components
	streamer := quizengine.NewGameStreamer()
	publisher := rabbitmq.NewPublisher(rmqConn)
	roundMgr := quizengine.NewRoundManager(rdb, publisher, streamer)

	// Start workers
	matchCreatedWorker := workers.NewMatchCreatedWorker(db, rdb, roundMgr)
	if err := matchCreatedWorker.Start(ctx, rmqConn); err != nil {
		log.Fatalf("Failed to start match-created worker: %v", err)
	}

	roundCompletedWorker := workers.NewRoundCompletedWorker(db, rdb, roundMgr, streamer)
	if err := roundCompletedWorker.Start(ctx, rmqConn); err != nil {
		log.Fatalf("Failed to start round-completed worker: %v", err)
	}

	// Start gRPC server
	srv := quizengine.NewServer(rdb, db, streamer, roundMgr, publisher)
	grpcServer := grpc.NewServer()
	srv.Register(grpcServer)
	reflection.Register(grpcServer)

	lis, err := net.Listen("tcp", fmt.Sprintf(":%s", cfg.GRPCPort))
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	go func() {
		log.Printf("Quiz Engine service started on port %s", cfg.GRPCPort)
		if err := grpcServer.Serve(lis); err != nil {
			log.Fatalf("Failed to serve: %v", err)
		}
	}()

	// Graceful shutdown
	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
	<-sigCh
	log.Println("Shutting down quiz engine service...")
	grpcServer.GracefulStop()
	cancel()
}

func getEnvOrDefault(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
