# Stage 1: Build all Go binaries
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /bin/matchmaking ./cmd/matchmaking
RUN CGO_ENABLED=0 go build -o /bin/quizengine ./cmd/quizengine
RUN CGO_ENABLED=0 go build -o /bin/scoring ./cmd/scoring
RUN CGO_ENABLED=0 go build -o /bin/seed ./scripts

# Stage: Seed
FROM alpine:3.19 AS seed
COPY --from=builder /bin/seed /seed
ENTRYPOINT ["/seed"]

# Stage: Matchmaking Service
FROM alpine:3.19 AS matchmaking
COPY --from=builder /bin/matchmaking /matchmaking
EXPOSE 50051
ENTRYPOINT ["/matchmaking"]

# Stage: Quiz Engine Service
FROM alpine:3.19 AS quizengine
COPY --from=builder /bin/quizengine /quizengine
EXPOSE 50052
ENTRYPOINT ["/quizengine"]

# Stage: Scoring Service
FROM alpine:3.19 AS scoring
COPY --from=builder /bin/scoring /scoring
EXPOSE 50053
ENTRYPOINT ["/scoring"]
