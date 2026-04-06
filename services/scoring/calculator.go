package scoring

import "math"

var basePointsByDifficulty = map[string]int32{
	"easy":   100,
	"medium": 200,
	"hard":   300,
}

// CalculatePoints computes the score for an answer
// Formula: base + speed_bonus (up to 50% of base)
func CalculatePoints(correct bool, difficulty string, responseTimeMs int64, timeLimitMs int32) int32 {
	if !correct {
		return 0
	}

	base, ok := basePointsByDifficulty[difficulty]
	if !ok {
		base = 100
	}

	// Speed bonus: faster answers get more points
	timeRatio := 1.0 - (float64(responseTimeMs) / float64(timeLimitMs))
	timeRatio = math.Max(0.0, timeRatio)

	speedBonus := int32(math.Floor(float64(base) * 0.5 * timeRatio))

	return base + speedBonus
}
