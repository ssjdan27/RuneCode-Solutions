WITH clean_customers AS (
  -- Defensively scrub exact duplicate rows and phantom nulls from the customers table
  SELECT DISTINCT id, name
  FROM customers
  WHERE id IS NOT NULL AND name IS NOT NULL
),
clean_orders AS (
  -- Defensively scrub the orders table to prevent cartesian duplication
  SELECT DISTINCT id, customer_id
  FROM orders
  WHERE id IS NOT NULL AND customer_id IS NOT NULL
),
clean_items AS (
  -- Clean the order items table (avoiding DISTINCT here so we don't accidentally drop two valid items with the exact same price)
  SELECT order_id, amount
  FROM order_items
  WHERE order_id IS NOT NULL AND amount IS NOT NULL
),
customer_totals AS (
  -- Join the clean tables and aggregate the total spend per customer
  SELECT 
    c.id,
    c.name,
    SUM(i.amount) AS lifetime_value
  FROM clean_customers c
  JOIN clean_orders o ON c.id = o.customer_id
  JOIN clean_items i ON o.id = i.order_id
  GROUP BY c.id, c.name
)
-- Output the final results with deterministic ordering
SELECT 
  name, 
  lifetime_value
FROM customer_totals
ORDER BY lifetime_value DESC, name ASC;