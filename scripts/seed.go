package main

import (
	"context"
	"log"
	"os"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	uri := os.Getenv("MONGO_URI")
	if uri == "" {
		uri = "mongodb://localhost:27017"
	}
	dbName := os.Getenv("MONGO_DB")
	if dbName == "" {
		dbName = "quizbattle"
	}

	client, err := mongo.Connect(ctx, options.Client().ApplyURI(uri))
	if err != nil {
		log.Fatalf("Failed to connect to MongoDB: %v", err)
	}
	defer client.Disconnect(ctx)

	db := client.Database(dbName)

	// Seed users
	seedUsers(ctx, db)
	// Seed questions
	seedQuestions(ctx, db)

	log.Println("Seeding completed successfully!")
}

func seedUsers(ctx context.Context, db *mongo.Database) {
	coll := db.Collection("users")
	coll.Drop(ctx)

	users := []interface{}{
		bson.M{"_id": primitive.NewObjectID(), "username": "QuizMaster99", "rating": int32(1500), "matchesPlayed": int32(0), "wins": int32(0)},
		bson.M{"_id": primitive.NewObjectID(), "username": "BrainStorm", "rating": int32(1450), "matchesPlayed": int32(0), "wins": int32(0)},
		bson.M{"_id": primitive.NewObjectID(), "username": "SpeedDemon", "rating": int32(1550), "matchesPlayed": int32(0), "wins": int32(0)},
		bson.M{"_id": primitive.NewObjectID(), "username": "TriviaKing", "rating": int32(1400), "matchesPlayed": int32(0), "wins": int32(0)},
		bson.M{"_id": primitive.NewObjectID(), "username": "NerdAlert", "rating": int32(1600), "matchesPlayed": int32(0), "wins": int32(0)},
		bson.M{"_id": primitive.NewObjectID(), "username": "QuickFire", "rating": int32(1480), "matchesPlayed": int32(0), "wins": int32(0)},
	}

	_, err := coll.InsertMany(ctx, users)
	if err != nil {
		log.Fatalf("Failed to seed users: %v", err)
	}

	// Create unique index on username
	coll.Indexes().CreateOne(ctx, mongo.IndexModel{
		Keys:    bson.M{"username": 1},
		Options: options.Index().SetUnique(true),
	})

	log.Printf("Seeded %d users", len(users))
}

func seedQuestions(ctx context.Context, db *mongo.Database) {
	coll := db.Collection("questions")
	coll.Drop(ctx)

	questions := []interface{}{
		// Easy - Science
		bson.M{"text": "What planet is known as the Red Planet?", "options": []string{"Venus", "Mars", "Jupiter", "Saturn"}, "correctIndex": int32(1), "difficulty": "easy", "topic": "science", "avgResponseTimeMs": int64(5000)},
		bson.M{"text": "What is the chemical symbol for water?", "options": []string{"H2O", "CO2", "NaCl", "O2"}, "correctIndex": int32(0), "difficulty": "easy", "topic": "science", "avgResponseTimeMs": int64(4000)},
		bson.M{"text": "How many legs does a spider have?", "options": []string{"6", "8", "10", "12"}, "correctIndex": int32(1), "difficulty": "easy", "topic": "science", "avgResponseTimeMs": int64(4500)},
		bson.M{"text": "What is the largest organ in the human body?", "options": []string{"Heart", "Liver", "Skin", "Brain"}, "correctIndex": int32(2), "difficulty": "easy", "topic": "science", "avgResponseTimeMs": int64(6000)},
		// Easy - History
		bson.M{"text": "Who was the first President of the United States?", "options": []string{"Thomas Jefferson", "George Washington", "Abraham Lincoln", "John Adams"}, "correctIndex": int32(1), "difficulty": "easy", "topic": "history", "avgResponseTimeMs": int64(4000)},
		bson.M{"text": "In which year did World War II end?", "options": []string{"1943", "1944", "1945", "1946"}, "correctIndex": int32(2), "difficulty": "easy", "topic": "history", "avgResponseTimeMs": int64(5000)},
		// Easy - Geography
		bson.M{"text": "What is the largest continent?", "options": []string{"Africa", "North America", "Europe", "Asia"}, "correctIndex": int32(3), "difficulty": "easy", "topic": "geography", "avgResponseTimeMs": int64(4500)},
		bson.M{"text": "What is the capital of France?", "options": []string{"London", "Berlin", "Paris", "Madrid"}, "correctIndex": int32(2), "difficulty": "easy", "topic": "geography", "avgResponseTimeMs": int64(3500)},
		bson.M{"text": "Which ocean is the largest?", "options": []string{"Atlantic", "Indian", "Arctic", "Pacific"}, "correctIndex": int32(3), "difficulty": "easy", "topic": "geography", "avgResponseTimeMs": int64(5000)},
		bson.M{"text": "What country has the most people?", "options": []string{"USA", "India", "China", "Russia"}, "correctIndex": int32(1), "difficulty": "easy", "topic": "geography", "avgResponseTimeMs": int64(5500)},

		// Medium - Science
		bson.M{"text": "What is the powerhouse of the cell?", "options": []string{"Nucleus", "Ribosome", "Mitochondria", "Endoplasmic Reticulum"}, "correctIndex": int32(2), "difficulty": "medium", "topic": "science", "avgResponseTimeMs": int64(6000)},
		bson.M{"text": "What is the speed of light in km/s (approximately)?", "options": []string{"150,000", "200,000", "300,000", "400,000"}, "correctIndex": int32(2), "difficulty": "medium", "topic": "science", "avgResponseTimeMs": int64(7000)},
		bson.M{"text": "Which element has the atomic number 79?", "options": []string{"Silver", "Gold", "Platinum", "Iron"}, "correctIndex": int32(1), "difficulty": "medium", "topic": "science", "avgResponseTimeMs": int64(8000)},
		bson.M{"text": "What gas do plants absorb from the atmosphere?", "options": []string{"Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"}, "correctIndex": int32(2), "difficulty": "medium", "topic": "science", "avgResponseTimeMs": int64(5500)},
		// Medium - History
		bson.M{"text": "Who painted the Mona Lisa?", "options": []string{"Michelangelo", "Raphael", "Leonardo da Vinci", "Donatello"}, "correctIndex": int32(2), "difficulty": "medium", "topic": "history", "avgResponseTimeMs": int64(5000)},
		bson.M{"text": "The ancient city of Rome was built on how many hills?", "options": []string{"5", "6", "7", "8"}, "correctIndex": int32(2), "difficulty": "medium", "topic": "history", "avgResponseTimeMs": int64(7000)},
		bson.M{"text": "Which empire was ruled by Genghis Khan?", "options": []string{"Ottoman", "Roman", "Mongol", "Persian"}, "correctIndex": int32(2), "difficulty": "medium", "topic": "history", "avgResponseTimeMs": int64(6000)},
		// Medium - Geography
		bson.M{"text": "What is the longest river in the world?", "options": []string{"Amazon", "Nile", "Mississippi", "Yangtze"}, "correctIndex": int32(1), "difficulty": "medium", "topic": "geography", "avgResponseTimeMs": int64(6500)},
		bson.M{"text": "Which country has the most time zones?", "options": []string{"Russia", "USA", "France", "China"}, "correctIndex": int32(2), "difficulty": "medium", "topic": "geography", "avgResponseTimeMs": int64(8000)},
		bson.M{"text": "What is the smallest country in the world?", "options": []string{"Monaco", "Vatican City", "San Marino", "Liechtenstein"}, "correctIndex": int32(1), "difficulty": "medium", "topic": "geography", "avgResponseTimeMs": int64(6000)},

		// Hard - Science
		bson.M{"text": "What is the half-life of Carbon-14 (approximately)?", "options": []string{"1,000 years", "5,730 years", "10,000 years", "50,000 years"}, "correctIndex": int32(1), "difficulty": "hard", "topic": "science", "avgResponseTimeMs": int64(9000)},
		bson.M{"text": "What is the Chandrasekhar limit?", "options": []string{"Max mass of white dwarf", "Min mass of black hole", "Max speed in vacuum", "Min temperature possible"}, "correctIndex": int32(0), "difficulty": "hard", "topic": "science", "avgResponseTimeMs": int64(10000)},
		bson.M{"text": "Which particle is responsible for the strong nuclear force?", "options": []string{"Photon", "W Boson", "Gluon", "Graviton"}, "correctIndex": int32(2), "difficulty": "hard", "topic": "science", "avgResponseTimeMs": int64(9500)},
		bson.M{"text": "What is the most abundant element in the universe?", "options": []string{"Oxygen", "Carbon", "Helium", "Hydrogen"}, "correctIndex": int32(3), "difficulty": "hard", "topic": "science", "avgResponseTimeMs": int64(7000)},
		// Hard - History
		bson.M{"text": "In what year was the Magna Carta signed?", "options": []string{"1066", "1215", "1492", "1776"}, "correctIndex": int32(1), "difficulty": "hard", "topic": "history", "avgResponseTimeMs": int64(8000)},
		bson.M{"text": "Who was the last pharaoh of Ancient Egypt?", "options": []string{"Nefertiti", "Cleopatra VII", "Hatshepsut", "Ramesses II"}, "correctIndex": int32(1), "difficulty": "hard", "topic": "history", "avgResponseTimeMs": int64(7500)},
		bson.M{"text": "The Thirty Years' War was primarily fought in which region?", "options": []string{"France", "Central Europe", "Britain", "Iberian Peninsula"}, "correctIndex": int32(1), "difficulty": "hard", "topic": "history", "avgResponseTimeMs": int64(9000)},
		// Hard - Geography
		bson.M{"text": "What is the driest inhabited continent?", "options": []string{"Africa", "Australia", "Asia", "South America"}, "correctIndex": int32(1), "difficulty": "hard", "topic": "geography", "avgResponseTimeMs": int64(8000)},
		bson.M{"text": "Which strait separates Europe from Africa?", "options": []string{"Bosphorus", "Hormuz", "Gibraltar", "Malacca"}, "correctIndex": int32(2), "difficulty": "hard", "topic": "geography", "avgResponseTimeMs": int64(7000)},
		bson.M{"text": "What is the deepest point in the ocean?", "options": []string{"Tonga Trench", "Mariana Trench", "Java Trench", "Puerto Rico Trench"}, "correctIndex": int32(1), "difficulty": "hard", "topic": "geography", "avgResponseTimeMs": int64(7500)},
	}

	_, err := coll.InsertMany(ctx, questions)
	if err != nil {
		log.Fatalf("Failed to seed questions: %v", err)
	}

	// Create index on difficulty for balanced selection
	coll.Indexes().CreateOne(ctx, mongo.IndexModel{
		Keys: bson.M{"difficulty": 1},
	})

	log.Printf("Seeded %d questions", len(questions))
}
