SELECT id, name, joined_at
FROM users
WHERE is_active = 1
ORDER BY joined_at ASC;
