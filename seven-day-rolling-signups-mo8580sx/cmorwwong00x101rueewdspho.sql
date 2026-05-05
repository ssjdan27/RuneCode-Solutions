WITH clean_sources AS (
  -- Defensively scrub the sources table and immediately filter out 'Internal' traffic
  SELECT DISTINCT id, source_name
  FROM sources
  WHERE id IS NOT NULL AND source_name != 'Internal'
),
clean_signups AS (
  -- Clean the signups table to avoid phantom nulls
  SELECT day, source_id, cnt
  FROM daily_signups
  WHERE day IS NOT NULL AND source_id IS NOT NULL AND cnt IS NOT NULL
),
daily_totals AS (
  -- First compute the total valid signups strictly per day
  SELECT 
    s.day,
    SUM(s.cnt) AS daily_cnt
  FROM clean_signups s
  JOIN clean_sources src ON s.source_id = src.id
  GROUP BY s.day
),
rolling_calc AS (
  -- Apply the 7-day rolling window using ROWS BETWEEN
  SELECT 
    day,
    SUM(daily_cnt) OVER (
      ORDER BY day ASC 
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7d
  FROM daily_totals
)
-- Output the final results with deterministic ordering
SELECT 
  day, 
  rolling_7d
FROM rolling_calc
ORDER BY day ASC;