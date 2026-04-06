package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type MatchHistory struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	RoomID    string             `bson:"roomId" json:"roomId"`
	Players   []MatchPlayer      `bson:"players" json:"players"`
	Rounds    int32              `bson:"rounds" json:"rounds"`
	Winner    string             `bson:"winner" json:"winner"`
	CreatedAt time.Time          `bson:"createdAt" json:"createdAt"`
	Duration  int64              `bson:"duration" json:"duration"` // milliseconds
}

type MatchPlayer struct {
	UserID            string `bson:"userId" json:"userId"`
	Username          string `bson:"username" json:"username"`
	FinalScore        int32  `bson:"finalScore" json:"finalScore"`
	Rank              int32  `bson:"rank" json:"rank"`
	AnswersCorrect    int32  `bson:"answersCorrect" json:"answersCorrect"`
	AvgResponseTimeMs int64  `bson:"avgResponseTimeMs" json:"avgResponseTimeMs"`
}
