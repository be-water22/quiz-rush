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
	"github.com/quizbattle/server/services/scoring"
	"github.com/quizbattle/server/services/scoring/workers"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	cfg := config.Load()
	cfg.GRPCPort = getEnvOrDefault("GRPC_PORT", "50053")
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

	// Start workers
	answerWorker := workers.NewAnswerWorker(rdb)
	if err := answerWorker.Start(ctx, rmqConn); err != nil {
		log.Fatalf("Failed to start answer worker: %v", err)
	}

	matchFinishedWorker := workers.NewMatchFinishedWorker(rdb, db)
	if err := matchFinishedWorker.Start(ctx, rmqConn); err != nil {
		log.Fatalf("Failed to start match-finished worker: %v", err)
	}

	// Start gRPC server
	srv := scoring.NewServer(rdb)
	grpcServer := grpc.NewServer()
	srv.Register(grpcServer)
	reflection.Register(grpcServer)

	lis, err := net.Listen("tcp", fmt.Sprintf(":%s", cfg.GRPCPort))
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	go func() {
		log.Printf("Scoring service started on port %s", cfg.GRPCPort)
		if err := grpcServer.Serve(lis); err != nil {
			log.Fatalf("Failed to serve: %v", err)
		}
	}()

	// Graceful shutdown
	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
	<-sigCh
	log.Println("Shutting down scoring service...")
	grpcServer.GracefulStop()
	cancel()
}

func getEnvOrDefault(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
