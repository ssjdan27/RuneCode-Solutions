WITH clean_orders AS (
  -- Defensively scrub exact duplicate rows and phantom nulls from the parent table
  SELECT DISTINCT id AS order_id, status
  FROM orders
  WHERE id IS NOT NULL AND status IS NOT NULL
),
clean_items AS (
  -- Clean the order items table (avoiding DISTINCT here so we don't accidentally drop two valid items with the exact same price)
  SELECT order_id, amount
  FROM order_items
  WHERE order_id IS NOT NULL AND amount IS NOT NULL
),
pending_totals AS (
  -- Filter for pending orders and aggregate their total amounts
  SELECT 
    o.order_id,
    SUM(i.amount) AS total_amount
  FROM clean_orders o
  JOIN clean_items i ON o.order_id = i.order_id
  WHERE o.status = 'pending'
  GROUP BY o.order_id
  -- Only include orders where the total amount is strictly greater than 100
  HAVING SUM(i.amount) > 100
)
-- Output the final results with deterministic ordering
SELECT 
  order_id, 
  total_amount
FROM pending_totals
ORDER BY total_amount DESC, order_id ASC;