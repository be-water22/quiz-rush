# Live Quiz Battle

A real-time multiplayer quiz game with a Go microservices backend and a Flutter frontend.

## Architecture Overview

```
                  Flutter App (Web / Desktop)
                    |              |
              gRPC (50051)    gRPC (50052)    gRPC (50053)
                    |              |               |
             Matchmaking      Quiz Engine       Scoring
              Service          Service          Service
                |    \          |    \           |    \
              Redis  RabbitMQ  Redis  RabbitMQ  Redis  RabbitMQ
                       \  MongoDB  /     \  MongoDB  /
                        ----------        ----------
```

Players join matchmaking, get grouped into rooms, answer timed quiz questions, and compete on a live leaderboard. Scores are calculated based on correctness and response speed.

---

## Backend Services

### 1. Matchmaking Service (port 50051)

Manages player queue and room creation using rating-based bucketing.

**gRPC RPCs:**

| RPC | Request | Response | Description |
|-----|---------|----------|-------------|
| `JoinMatchmaking` | `JoinRequest` | `JoinResponse` | Add player to the matchmaking pool |
| `LeaveMatchmaking` | `LeaveRequest` | `LeaveResponse` | Remove player from the pool |
| `SubscribeToMatch` | `SubscribeRequest` | `stream MatchEvent` | Stream of wait updates and match-found events |

**Key Components:**
- **Pool** (`services/matchmaking/pool.go`) - Redis sorted set ordered by rating, with player data in hashes
- **Matcher** (`services/matchmaking/matcher.go`) - Runs every 1s, groups players by rating buckets (200-point ranges), forms matches with 2-10 players
- **Room Manager** (`services/matchmaking/room.go`) - Creates room state, players, leaderboard, and round counter in Redis
- **Lock** (`services/matchmaking/lock.go`) - Distributed lock via Redis `SET NX EX` for safe room creation
- **Streamer** (`services/matchmaking/streamer.go`) - In-memory channel map to push match events to connected clients

---

### 2. Quiz Engine Service (port 50052)

Handles question selection, round lifecycle, answer validation, and game event streaming.

**gRPC RPCs:**

| RPC | Request | Response | Description |
|-----|---------|----------|-------------|
| `GetRoomQuestions` | `RoomRequest` | `QuestionsResponse` | Fetch all questions for a room |
| `SubmitAnswer` | `AnswerRequest` | `AnswerAck` | Submit an answer (idempotent via `HSETNX`) |
| `StreamGameEvents` | `StreamRequest` | `stream GameEvent` | Stream questions, timer syncs, round results, leaderboard updates, match end |

**Game Events (streamed to clients):**
- `QuestionBroadcast` - New question with options and deadline
- `TimerSync` - Server-time countdown sync every 5s
- `RoundResult` - Correct answer + per-player results
- `LeaderboardUpdate` - Rankings after each round
- `MatchEnd` - Final standings, winner, stats
- `PlayerJoined` - Player connection notification

**Key Components:**
- **Question Selector** (`services/quizengine/selector.go`) - Picks questions from MongoDB using `$sample` aggregation, balanced by difficulty (40% easy, 40% medium, 20% hard for 5 rounds: easy, easy, medium, medium, hard)
- **Round Manager** (`services/quizengine/round.go`) - Starts rounds, manages timers, detects all-answered, publishes round.completed/match.finished events
- **Game Streamer** (`services/quizengine/streamer.go`) - Room-scoped channel map (`roomID -> userID -> channel`)

**Workers (RabbitMQ consumers):**
- `match-created-queue` - Selects questions, caches them in Redis, starts round 1
- `round-completed-queue` - Broadcasts round result + leaderboard, starts next round after 5s delay, or ends match

---

### 3. Scoring Service (port 50053)

Calculates scores and maintains leaderboards.

**gRPC RPCs:**

| RPC | Request | Response | Description |
|-----|---------|----------|-------------|
| `CalculateScore` | `ScoreRequest` | `ScoreResponse` | Calculate and update score for an answer |
| `GetLeaderboard` | `LeaderboardRequest` | `LeaderboardResponse` | Get current room leaderboard |

**Scoring Formula:**
```
Wrong answer = 0 points
Correct answer = base + speed_bonus

Base points:  easy = 100,  medium = 200,  hard = 300
Speed bonus:  base * 0.5 * max(0, 1 - response_time / time_limit)

Max per question:  easy = 150,  medium = 300,  hard = 450
```

**Key Components:**
- **Calculator** (`services/scoring/calculator.go`) - Pure scoring function
- **Leaderboard** (`services/scoring/leaderboard.go`) - Atomic score updates via Lua script (`ZINCRBY` + `ZREVRANK`)

**Workers:**
- `answer-processing-queue` - Scores individual answers with idempotency check
- `match-finished-queue` - Persists match history to MongoDB, increments user stats (matchesPlayed, wins)

---

## Infrastructure

### MongoDB Collections

| Collection | Fields | Indexes |
|------------|--------|---------|
| `users` | `_id`, `username`, `rating`, `matchesPlayed`, `wins` | Unique on `username` |
| `questions` | `_id`, `text`, `options[]`, `correctIndex`, `difficulty`, `topic`, `avgResponseTimeMs` | On `difficulty` |
| `match_history` | `_id`, `roomId`, `players[]`, `rounds`, `winner`, `createdAt`, `duration` | - |

`match_history.players[]` embeds: `userId`, `username`, `finalScore`, `rank`, `answersCorrect`, `avgResponseTimeMs`

### Redis Keys

| Key Pattern | Type | TTL | Purpose |
|-------------|------|-----|---------|
| `matchmaking:pool` | Sorted Set | - | Player queue sorted by rating |
| `matchmaking:player:{userId}` | Hash | 5m | Player metadata (username, rating, joinedAt) |
| `room:{roomId}:state` | String (JSON) | 30m | Room state (waiting/in_progress/finished) |
| `room:{roomId}:players` | Hash | 30m | Player data keyed by userId |
| `room:{roomId}:round` | String (int) | 30m | Current round number |
| `room:{roomId}:leaderboard` | Sorted Set | 30m | Scores sorted descending |
| `room:{roomId}:questions` | List | 30m | Ordered question IDs for the match |
| `room:{roomId}:question:{qId}` | String (JSON) | 30m | Cached question data |
| `room:{roomId}:answers:{round}` | Hash | 30m | Player answers per round (HSETNX for idempotency) |
| `room:{roomId}:scored:{round}` | Hash | - | Scoring idempotency check |
| `room:lock:{roomId}` | String | 10s | Distributed lock for room creation |

### RabbitMQ

**Exchange:** `sx` (topic, durable)

| Queue | Routing Key | Consumer | DLQ |
|-------|-------------|----------|-----|
| `match-created-queue` | `match.created` | Quiz Engine | `match-created-queue-dlq` |
| `answer-processing-queue` | `answer.submitted` | Scoring | `answer-processing-queue-dlq` |
| `round-completed-queue` | `round.completed` | Quiz Engine | `round-completed-queue-dlq` |
| `match-finished-queue` | `match.finished` | Scoring | `match-finished-queue-dlq` |

All queues: durable, prefetch=10, persistent delivery, dead-letter routing to DLQ on processing failure.

### Lua Scripts

| Script | Purpose |
|--------|---------|
| `internal/lua/matchmaking_pop.lua` | Atomically remove players from matchmaking pool |
| `internal/lua/leaderboard_update.lua` | Atomically increment score and return new rank |
| `internal/lua/acquire_lock.lua` | Distributed lock acquisition (SET NX EX) |

---

## Flutter App

The frontend is a Flutter app that runs on **web (Chrome)**, **Windows desktop**, or **mobile**.

### Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Login | `/` | Username + password login (password: `1234`) |
| Profile | `/profile` | Player stats - accuracy, avg rank, best streak, total score, etc. |
| Matchmaking | `/matchmaking` | Radar animation, finds 5-10 random opponents from a 25-player lobby |
| Gameplay | `/game/:matchId` | Timed questions, answer options, mini leaderboard, countdown timer |
| Leaderboard | `/leaderboard/:matchId` | Full leaderboard between rounds with countdown to next round |
| Results | `/results/:matchId` | Final standings, winner, personal stats, XP display |

### State Management

Uses **Riverpod** with `StateNotifier` providers:
- `currentUserProvider` - Logged-in player info
- `matchmakingProvider` - Matchmaking state (searching/found/idle)
- `gameProvider` - Active game state (question, timer, score, leaderboard)
- `userStatsProvider` - Cumulative stats across games (persists within session)

### Simulated Backend

The Flutter app includes simulated gRPC clients with mock data for demo purposes:
- **25 unique lobby players** randomly drawn for each match
- **25 GK questions** across easy/medium/hard, 5 randomly picked per game
- **Opponents** get random accuracy (50-85%) and speed (30-70% of time limit)
- **Scoring** uses the same formula as the backend (base + speed bonus)

---

## Setup & Run

### Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| **Go** | 1.22+ | https://go.dev/dl/ |
| **Flutter** | 3.29+ | https://docs.flutter.dev/get-started/install |
| **Docker Desktop** | Latest | https://docs.docker.com/desktop/install/windows-install/ |
| **Git** | Latest | https://git-scm.com/downloads |

### Option 1: Flutter App Only (Demo Mode)

The Flutter app works standalone with simulated data - no backend needed.

```bash
# Install Flutter dependencies
cd flutter_app
flutter pub get

# Run on Chrome browser
flutter run -d chrome

# Or on Windows desktop (requires Visual Studio C++ workload)
flutter run -d windows
```

For the best mobile-like experience in Chrome, press **F12** and toggle the device toolbar to simulate a phone screen (e.g., iPhone 14 Pro).

### Option 2: Full Stack (Backend + Frontend)

#### 1. Start Infrastructure + Backend

```bash
# Start everything with Docker (MongoDB, Redis, RabbitMQ, seed, all 3 services)
docker-compose up --build

# Or start infrastructure only and run services locally:
make run-infra
make run-matchmaking    # terminal 1
make run-quizengine     # terminal 2
make run-scoring        # terminal 3
```

#### 2. Seed the Database

If running via Docker, seeding happens automatically. For local:

```bash
make seed
```

#### 3. Generate Protobuf Code (if modifying .proto files)

```bash
# Go server
make proto

# Flutter client
make flutter-proto
```

#### 4. Run the Flutter App

```bash
cd flutter_app
flutter pub get
flutter run -d chrome
```

### Service Ports

| Service | Port | URL |
|---------|------|-----|
| Matchmaking gRPC | 50051 | `localhost:50051` |
| Quiz Engine gRPC | 50052 | `localhost:50052` |
| Scoring gRPC | 50053 | `localhost:50053` |
| MongoDB | 27017 | `mongodb://localhost:27017` |
| Redis | 6379 | `localhost:6379` |
| RabbitMQ | 5672 | `amqp://quiz:quiz@localhost:5672/` |
| RabbitMQ Management UI | 15672 | `http://localhost:15672` (quiz/quiz) |

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `GRPC_PORT` | `50051` | gRPC server port |
| `REDIS_ADDR` | `localhost:6379` | Redis connection address |
| `MONGO_URI` | `mongodb://localhost:27017` | MongoDB connection URI |
| `MONGO_DB` | `quizbattle` | MongoDB database name |
| `RABBITMQ_URL` | `amqp://quiz:quiz@localhost:5672/` | RabbitMQ connection URL |

---

## Project Structure

```
live-quiz-battle/
  proto/                          # Protobuf definitions
    matchmaking/v1/matchmaking.proto
    quiz/v1/quiz.proto
    scoring/v1/scoring.proto
  gen/                            # Generated Go protobuf code
  internal/                       # Shared packages
    config/                       # Environment config loader
    mongodb/                      # MongoDB client
    redisclient/                  # Redis client
    rabbitmq/                     # RabbitMQ connection, publisher, consumer
    models/                       # MongoDB document models
    lua/                          # Redis Lua scripts
  services/
    matchmaking/                  # Matchmaking service logic
    quizengine/                   # Quiz engine service logic
      workers/                    # RabbitMQ consumers
    scoring/                      # Scoring service logic
      workers/                    # RabbitMQ consumers
  cmd/
    matchmaking/main.go           # Matchmaking service entrypoint
    quizengine/main.go            # Quiz engine entrypoint
    scoring/main.go               # Scoring service entrypoint
  scripts/seed.go                 # Database seeder
  flutter_app/
    lib/
      models/                     # Data models (Player, Question, GameState, etc.)
      providers/                  # Riverpod state management
      services/
        grpc/                     # gRPC channel + simulated clients
        lobby.dart                # 25-player NPC lobby pool
      screens/
        login/                    # Login screen
        profile/                  # Profile + stats screen
        matchmaking/              # Matchmaking with radar animation
        gameplay/                 # Question + timer + options UI
        leaderboard/              # Between-round leaderboard
        results/                  # Final standings + stats
      widgets/                    # Reusable widgets (avatar, rank badge, etc.)
      theme/                      # Dark theme + color definitions
      routing/                    # GoRouter configuration
  Dockerfile                      # Multi-stage build for all Go services
  docker-compose.yml              # Full stack orchestration
  Makefile                        # Build, run, proto generation commands
```
