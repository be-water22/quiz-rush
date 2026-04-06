.PHONY: proto build run-infra run-all seed clean

# Generate protobuf Go code
proto:
	protoc --go_out=gen --go_opt=paths=source_relative \
		--go-grpc_out=gen --go-grpc_opt=paths=source_relative \
		-I proto proto/matchmaking/v1/matchmaking.proto
	protoc --go_out=gen --go_opt=paths=source_relative \
		--go-grpc_out=gen --go-grpc_opt=paths=source_relative \
		-I proto proto/quiz/v1/quiz.proto
	protoc --go_out=gen --go_opt=paths=source_relative \
		--go-grpc_out=gen --go-grpc_opt=paths=source_relative \
		-I proto proto/scoring/v1/scoring.proto

# Build all services
build:
	go build -o bin/matchmaking ./cmd/matchmaking
	go build -o bin/quizengine ./cmd/quizengine
	go build -o bin/scoring ./cmd/scoring
	go build -o bin/seed ./scripts

# Run infrastructure only (Redis, MongoDB, RabbitMQ)
run-infra:
	docker-compose up -d mongodb redis rabbitmq

# Seed the database
seed: run-infra
	go run ./scripts

# Run all services with Docker
run-all:
	docker-compose up --build

# Run individual services locally
run-matchmaking:
	go run ./cmd/matchmaking

run-quizengine:
	GRPC_PORT=50052 go run ./cmd/quizengine

run-scoring:
	GRPC_PORT=50053 go run ./cmd/scoring

# Generate Flutter proto files
flutter-proto:
	protoc --dart_out=grpc:flutter_app/lib/generated \
		-I proto proto/matchmaking/v1/matchmaking.proto
	protoc --dart_out=grpc:flutter_app/lib/generated \
		-I proto proto/quiz/v1/quiz.proto
	protoc --dart_out=grpc:flutter_app/lib/generated \
		-I proto proto/scoring/v1/scoring.proto

# Clean build artifacts
clean:
	rm -rf bin/
	docker-compose down -v
