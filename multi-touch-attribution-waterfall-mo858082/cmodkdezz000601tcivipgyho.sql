WITH clean_conversions AS (
  -- Defensively scrub duplicate rows and phantom nulls
  SELECT DISTINCT conv_id, user_id, conv_ts, revenue
  FROM conversions
  WHERE conv_id IS NOT NULL AND user_id IS NOT NULL
),
clean_touches AS (
  -- Clean the touch events to ensure deterministic behavior
  SELECT DISTINCT user_id, session_id, touch_ts, channel
  FROM touch_events
  WHERE user_id IS NOT NULL
),
qual AS (
  SELECT 
    c.conv_id, 
    c.revenue, 
    t.channel, 
    t.touch_ts, 
    t.session_id
  FROM clean_conversions c
  JOIN clean_touches t
    ON t.user_id = c.user_id
   AND t.touch_ts <= c.conv_ts
   AND t.touch_ts > datetime(c.conv_ts, '-14 days')
),
ranked AS (
  SELECT
    conv_id, 
    channel,
    ROW_NUMBER() OVER (PARTITION BY conv_id ORDER BY touch_ts ASC, session_id ASC) AS rn_first,
    ROW_NUMBER() OVER (PARTITION BY conv_id ORDER BY touch_ts DESC, session_id DESC) AS rn_last
  FROM qual
),
first_ch AS (
  SELECT conv_id, channel AS first_channel 
  FROM ranked 
  WHERE rn_first = 1
),
last_ch  AS (
  SELECT conv_id, channel AS last_channel  
  FROM ranked 
  WHERE rn_last = 1
),
path_channels AS (
  SELECT DISTINCT conv_id, channel 
  FROM qual
),
weighted AS (
  SELECT
    p.conv_id,
    p.channel,
    COALESCE(cw.weight, 0) AS weight,
    SUM(COALESCE(cw.weight, 0)) OVER (PARTITION BY p.conv_id) AS total_weight
  FROM path_channels p
  LEFT JOIN channel_weights cw ON cw.channel = p.channel
),
allocations AS (
  SELECT
    c.conv_id,
    w.channel,
      CASE WHEN w.channel = l.last_channel  THEN 0.40 * c.revenue ELSE 0 END
    + CASE WHEN w.channel = f.first_channel THEN 0.20 * c.revenue ELSE 0 END
    + CASE WHEN w.total_weight > 0
           THEN 0.40 * c.revenue * w.weight / w.total_weight
           ELSE 0 END
    AS attributed_revenue
  FROM clean_conversions c
  JOIN weighted w  ON w.conv_id = c.conv_id
  JOIN first_ch f  ON f.conv_id = c.conv_id
  JOIN last_ch  l  ON l.conv_id = c.conv_id
),
no_touch AS (
  SELECT 
    c.conv_id,
    'DIRECT_UNKNOWN' AS channel,
    c.revenue        AS attributed_revenue
  FROM clean_conversions c
  WHERE NOT EXISTS (SELECT 1 FROM qual q WHERE q.conv_id = c.conv_id)
),
final_output AS (
  SELECT conv_id, channel, attributed_revenue FROM allocations
  UNION ALL
  SELECT conv_id, channel, attributed_revenue FROM no_touch
)
SELECT conv_id, channel, attributed_revenue 
FROM final_output
WHERE conv_id = 501
ORDER BY conv_id ASC, channel ASC;