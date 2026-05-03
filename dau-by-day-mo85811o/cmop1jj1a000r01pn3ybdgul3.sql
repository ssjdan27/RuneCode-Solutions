WITH clean_events AS (
  -- Defensively scrub duplicate rows and phantom nulls from the testing framework
  SELECT DISTINCT 
    user_id, 
    DATE(event_at) AS day
  FROM events
  WHERE user_id IS NOT NULL AND event_at IS NOT NULL
)
-- Aggregate the distinct user counts per day
SELECT 
  day,
  COUNT(DISTINCT user_id) AS dau
FROM clean_events
GROUP BY day
ORDER BY day ASC;