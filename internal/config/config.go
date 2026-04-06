package config

import "os"

type Config struct {
	GRPCPort    string
	RedisAddr   string
	MongoURI    string
	MongoDB     string
	RabbitMQURL string
}

func Load() *Config {
	return &Config{
		GRPCPort:    getEnv("GRPC_PORT", "50051"),
		RedisAddr:   getEnv("REDIS_ADDR", "localhost:6379"),
		MongoURI:    getEnv("MONGO_URI", "mongodb://localhost:27017"),
		MongoDB:     getEnv("MONGO_DB", "quizbattle"),
		RabbitMQURL: getEnv("RABBITMQ_URL", "amqp://quiz:quiz@localhost:5672/"),
	}
}

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
