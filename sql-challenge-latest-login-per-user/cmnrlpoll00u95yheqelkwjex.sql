SELECT
  user_id,
  MAX(login_at) AS last_login_at
FROM logins
GROUP BY user_id
ORDER BY user_id ASC;