WITH clean_logins AS (
  SELECT DISTINCT user_id, login_at
  FROM logins
  WHERE user_id IS NOT NULL AND login_at IS NOT NULL
)
SELECT 
  user_id,
  MAX(login_at) AS last_login_at
FROM clean_logins
GROUP BY user_id
ORDER BY user_id ASC;