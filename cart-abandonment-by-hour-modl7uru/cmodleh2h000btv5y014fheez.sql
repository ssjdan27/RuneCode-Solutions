WITH clean_carts AS (
  -- Defensively scrub duplicate rows and phantom nulls from cart events
  SELECT DISTINCT user_id, product_id, added_at
  FROM cart_events
  WHERE user_id IS NOT NULL AND product_id IS NOT NULL
),
clean_orders AS (
  -- Clean the orders table
  SELECT DISTINCT order_id, user_id, ordered_at
  FROM orders
  WHERE user_id IS NOT NULL AND order_id IS NOT NULL
),
clean_order_items AS (
  -- Clean the order items table
  SELECT DISTINCT order_id, product_id
  FROM order_items
  WHERE order_id IS NOT NULL AND product_id IS NOT NULL
),
purchases AS (
  -- Pre-join valid purchases to avoid heavy nested joins later
  SELECT 
    o.user_id, 
    oi.product_id, 
    o.ordered_at
  FROM clean_orders o
  JOIN clean_order_items oi ON o.order_id = oi.order_id
),
cart_status AS (
  -- Evaluate each distinct cart addition for a matching purchase within 24 hours
  SELECT 
    c.user_id,
    c.product_id,
    c.added_at,
    CAST(STRFTIME('%H', c.added_at) AS INTEGER) AS hour_of_day,
    CASE WHEN EXISTS (
      SELECT 1
      FROM purchases p
      WHERE p.user_id = c.user_id
        AND p.product_id = c.product_id
        AND p.ordered_at >= c.added_at
        AND p.ordered_at <= DATETIME(c.added_at, '+24 hours')
    ) THEN 1 ELSE 0 END AS is_purchased
  FROM clean_carts c
)
-- Aggregate the hourly results
SELECT 
  hour_of_day,
  COUNT(*) AS cart_count,
  SUM(is_purchased) AS purchased_count,
  (COUNT(*) - SUM(is_purchased)) AS abandoned_count,
  -- Multiply by 1.0 to force float division before rounding
  ROUND(1.0 * (COUNT(*) - SUM(is_purchased)) / COUNT(*), 4) AS abandonment_rate
FROM cart_status
GROUP BY hour_of_day
ORDER BY hour_of_day ASC;