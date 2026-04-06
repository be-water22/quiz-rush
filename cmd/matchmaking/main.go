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
	"github.com/quizbattle/server/internal/rabbitmq"
	"github.com/quizbattle/server/internal/redisclient"
	"github.com/quizbattle/server/services/matchmaking"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	cfg := config.Load()
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// Connect to Redis
	rdb, err := redisclient.Connect(ctx, cfg.RedisAddr)
	if err != nil {
		log.Fatalf("Failed to connect to Redis: %v", err)
	}
	defer rdb.Close()

	// Connect to RabbitMQ
	rmqConn, err := rabbitmq.NewConnection(cfg.RabbitMQURL)
	if err != nil {
		log.Fatalf("Failed to connect to RabbitMQ: %v", err)
	}
	defer rmqConn.Close()

	// Initialize components
	pool := matchmaking.NewPool(rdb)
	roomMgr := matchmaking.NewRoomManager(rdb)
	lock := matchmaking.NewLock(rdb)
	streamer := matchmaking.NewStreamer()
	publisher := rabbitmq.NewPublisher(rmqConn)

	// Start matcher background loop
	matcher := matchmaking.NewMatcher(pool, roomMgr, lock, streamer, publisher)
	go matcher.Start(ctx)

	// Start gRPC server
	srv := matchmaking.NewServer(pool, streamer)
	grpcServer := grpc.NewServer()
	srv.Register(grpcServer)
	reflection.Register(grpcServer)

	lis, err := net.Listen("tcp", fmt.Sprintf(":%s", cfg.GRPCPort))
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	go func() {
		log.Printf("Matchmaking service started on port %s", cfg.GRPCPort)
		if err := grpcServer.Serve(lis); err != nil {
			log.Fatalf("Failed to serve: %v", err)
		}
	}()

	// Graceful shutdown
	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
	<-sigCh
	log.Println("Shutting down matchmaking service...")
	grpcServer.GracefulStop()
	cancel()
}
