package quizengine

import (
	"context"

	"github.com/quizbattle/server/internal/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

// DifficultyDistribution returns the difficulty sequence for a given number of rounds
func DifficultyDistribution(rounds int32) []string {
	switch rounds {
	case 5:
		return []string{"easy", "easy", "medium", "medium", "hard"}
	case 7:
		return []string{"easy", "easy", "medium", "medium", "medium", "hard", "hard"}
	case 10:
		return []string{"easy", "easy", "easy", "medium", "medium", "medium", "medium", "hard", "hard", "hard"}
	default:
		// 40% easy, 40% medium, 20% hard
		dist := make([]string, rounds)
		easy := int(float64(rounds) * 0.4)
		med := int(float64(rounds) * 0.4)
		for i := int32(0); i < rounds; i++ {
			if int(i) < easy {
				dist[i] = "easy"
			} else if int(i) < easy+med {
				dist[i] = "medium"
			} else {
				dist[i] = "hard"
			}
		}
		return dist
	}
}

type QuestionSelector struct {
	collection *mongo.Collection
}

func NewQuestionSelector(db *mongo.Database) *QuestionSelector {
	return &QuestionSelector{
		collection: db.Collection("questions"),
	}
}

func (qs *QuestionSelector) SelectForMatch(ctx context.Context, totalRounds int32) ([]models.Question, error) {
	distribution := DifficultyDistribution(totalRounds)

	// Count how many of each difficulty we need
	counts := make(map[string]int)
	for _, d := range distribution {
		counts[d]++
	}

	var allQuestions []models.Question

	for difficulty, count := range counts {
		questions, err := qs.selectByDifficulty(ctx, difficulty, count)
		if err != nil {
			return nil, err
		}
		allQuestions = append(allQuestions, questions...)
	}

	// Reorder according to distribution
	questionsByDifficulty := make(map[string][]models.Question)
	for _, q := range allQuestions {
		questionsByDifficulty[q.Difficulty] = append(questionsByDifficulty[q.Difficulty], q)
	}

	ordered := make([]models.Question, 0, totalRounds)
	diffIdx := make(map[string]int)
	for _, d := range distribution {
		if idx := diffIdx[d]; idx < len(questionsByDifficulty[d]) {
			ordered = append(ordered, questionsByDifficulty[d][idx])
			diffIdx[d]++
		}
	}

	return ordered, nil
}

func (qs *QuestionSelector) selectByDifficulty(ctx context.Context, difficulty string, count int) ([]models.Question, error) {
	pipeline := mongo.Pipeline{
		{{Key: "$match", Value: bson.M{"difficulty": difficulty}}},
		{{Key: "$sample", Value: bson.M{"size": count}}},
	}

	cursor, err := qs.collection.Aggregate(ctx, pipeline)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)

	var questions []models.Question
	if err := cursor.All(ctx, &questions); err != nil {
		return nil, err
	}
	return questions, nil
}

func (qs *QuestionSelector) GetByID(ctx context.Context, questionID string) (*models.Question, error) {
	var q models.Question
	oid, err := primitiveObjectIDFromHex(questionID)
	if err != nil {
		return nil, err
	}
	err = qs.collection.FindOne(ctx, bson.M{"_id": oid}).Decode(&q)
	if err != nil {
		return nil, err
	}
	return &q, nil
}
