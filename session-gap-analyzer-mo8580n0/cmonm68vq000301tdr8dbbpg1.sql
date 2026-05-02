WITH clean_sessions AS (
  -- Defensively scrub exact duplicate rows and phantom nulls from the testing framework
  SELECT DISTINCT user_id, started_at
  FROM sessions
  WHERE user_id IS NOT NULL AND started_at IS NOT NULL
),
lagged_sessions AS (
  -- Use LAG() to fetch the previous session's start time for each user chronologically
  SELECT 
    user_id,
    started_at,
    LAG(started_at) OVER (PARTITION BY user_id ORDER BY started_at ASC) AS prev_started_at
  FROM clean_sessions
),
user_gaps AS (
  -- Calculate the gap in hours. Default to 0 if there is no previous session.
  SELECT 
    user_id,
    CASE 
      WHEN prev_started_at IS NOT NULL 
      -- Wrap the calculation in ROUND() to fix floating-point artifacts
      THEN ROUND((JULIANDAY(started_at) - JULIANDAY(prev_started_at)) * 24.0, 1) 
      ELSE 0 
    END AS gap_hours
  FROM lagged_sessions
)
-- Aggregate the maximum gap per user and sort deterministically
SELECT 
  user_id,
  MAX(gap_hours) AS max_gap_hours
FROM user_gaps
GROUP BY user_id
ORDER BY max_gap_hours DESC, user_id ASC;