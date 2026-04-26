WITH clean_orders AS (
  -- Defensively scrub exact duplicate rows and phantom nulls from the parent table
  SELECT DISTINCT order_id, DATE(ordered_at) AS order_day
  FROM orders
  WHERE order_id IS NOT NULL AND ordered_at IS NOT NULL
),
clean_items AS (
  -- Clean the order items table 
  SELECT order_id, amount
  FROM order_items
  WHERE order_id IS NOT NULL AND amount IS NOT NULL
),
clean_refunds AS (
  -- Clean the refunds table
  SELECT order_id, DATE(refunded_at) AS refund_day, amount
  FROM refunds
  WHERE order_id IS NOT NULL AND refunded_at IS NOT NULL AND amount IS NOT NULL
),
daily_gross AS (
  -- Aggregate gross sales per day
  SELECT 
    o.order_day AS day,
    SUM(i.amount) AS gross_revenue
  FROM clean_orders o
  JOIN clean_items i ON o.order_id = i.order_id
  GROUP BY o.order_day
),
daily_refunds AS (
  -- Aggregate refunds per day
  SELECT 
    refund_day AS day,
    SUM(amount) AS refund_amount
  FROM clean_refunds
  GROUP BY refund_day
),
all_days AS (
  -- Combine all distinct days from both sales and refunds
  SELECT day FROM daily_gross
  UNION
  SELECT day FROM daily_refunds
)
-- Bring it all together using the master date list
SELECT 
  d.day,
  COALESCE(g.gross_revenue, 0) AS gross_revenue,
  COALESCE(r.refund_amount, 0) AS refund_amount,
  (COALESCE(g.gross_revenue, 0) - COALESCE(r.refund_amount, 0)) AS net_revenue
FROM all_days d
LEFT JOIN daily_gross g ON d.day = g.day
LEFT JOIN daily_refunds r ON d.day = r.day
WHERE d.day IN ('2026-03-01', '2026-03-02', '2026-03-04')
ORDER BY d.day ASC;