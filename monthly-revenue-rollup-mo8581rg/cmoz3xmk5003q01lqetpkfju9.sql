WITH clean_orders AS (
  -- Defensively scrub exact duplicate rows and phantom nulls from the orders table
  -- Automatically format the date to YYYY-MM while staging
  SELECT DISTINCT id, STRFTIME('%Y-%m', placed_at) AS month
  FROM orders
  WHERE id IS NOT NULL AND placed_at IS NOT NULL
),
clean_products AS (
  -- Defensively scrub the products table
  SELECT DISTINCT id, category, price
  FROM products
  WHERE id IS NOT NULL AND category IS NOT NULL AND price IS NOT NULL
),
clean_items AS (
  -- Clean the order items table 
  -- (Avoiding DISTINCT here so we don't accidentally drop two valid items in the same order if they happen to share a product_id)
  SELECT order_id, product_id, qty
  FROM order_items
  WHERE order_id IS NOT NULL AND product_id IS NOT NULL AND qty IS NOT NULL
),
monthly_revenue AS (
  -- Join the clean tables and aggregate the total revenue per month/category
  SELECT 
    o.month,
    p.category,
    SUM(i.qty * p.price) AS revenue
  FROM clean_orders o
  JOIN clean_items i ON o.id = i.order_id
  JOIN clean_products p ON i.product_id = p.id
  GROUP BY o.month, p.category
)
-- Output the final results with deterministic ordering
SELECT 
  month, 
  category, 
  revenue
FROM monthly_revenue
ORDER BY month ASC, category ASC;