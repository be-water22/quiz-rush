package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Question struct {
	ID                primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	Text              string             `bson:"text" json:"text"`
	Options           []string           `bson:"options" json:"options"`
	CorrectIndex      int32              `bson:"correctIndex" json:"correctIndex"`
	Difficulty        string             `bson:"difficulty" json:"difficulty"` // "easy", "medium", "hard"
	Topic             string             `bson:"topic" json:"topic"`
	AvgResponseTimeMs int64              `bson:"avgResponseTimeMs" json:"avgResponseTimeMs"`
}
