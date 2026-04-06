-- Atomically update leaderboard score and return new rank
-- KEYS[1] = room:{id}:leaderboard
-- ARGV[1] = user_id
-- ARGV[2] = points to add
-- Returns: {new_total_score, new_rank (0-based)}
redis.call('ZINCRBY', KEYS[1], ARGV[2], ARGV[1])
local score = redis.call('ZSCORE', KEYS[1], ARGV[1])
local rank = redis.call('ZREVRANK', KEYS[1], ARGV[1])
return {tonumber(score), rank}
