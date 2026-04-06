package quizengine

import "go.mongodb.org/mongo-driver/bson/primitive"

func primitiveObjectIDFromHex(hex string) (primitive.ObjectID, error) {
	return primitive.ObjectIDFromHex(hex)
}
