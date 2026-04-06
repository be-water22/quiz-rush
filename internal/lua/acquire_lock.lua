-- Acquire a distributed lock
-- KEYS[1] = lock key
-- ARGV[1] = lock value (UUID)
-- ARGV[2] = TTL in seconds
-- Returns: 1 if acquired, 0 if not
if redis.call('SET', KEYS[1], ARGV[1], 'NX', 'EX', ARGV[2]) then
  return 1
end
return 0
