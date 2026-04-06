package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type User struct {
	ID            primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	Username      string             `bson:"username" json:"username"`
	Rating        int32              `bson:"rating" json:"rating"`
	MatchesPlayed int32              `bson:"matchesPlayed" json:"matchesPlayed"`
	Wins          int32              `bson:"wins" json:"wins"`
}
