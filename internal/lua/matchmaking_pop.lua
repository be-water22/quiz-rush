-- Atomically remove players from matchmaking pool
-- KEYS[1] = matchmaking:pool
-- ARGV = list of user_ids to remove
-- Returns: list of user_ids actually removed
local removed = {}
for i, uid in ipairs(ARGV) do
  local result = redis.call('ZREM', KEYS[1], uid)
  if result == 1 then
    table.insert(removed, uid)
  end
end
return removed
