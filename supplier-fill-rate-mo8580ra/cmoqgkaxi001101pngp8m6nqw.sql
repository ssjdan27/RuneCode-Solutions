WITH clean_pos AS (
  -- Defensively scrub exact duplicate rows and phantom nulls from the parent table
  SELECT DISTINCT po_id, supplier_id, STRFTIME('%Y-%m', ordered_at) AS month
  FROM purchase_orders
  WHERE po_id IS NOT NULL AND supplier_id IS NOT NULL AND ordered_at IS NOT NULL
),
agg_lines AS (
  -- Pre-aggregate ordered quantities by po_id and sku to prevent cartesian joins
  SELECT po_id, sku, SUM(qty_ordered) AS qty_ordered
  FROM po_lines
  WHERE po_id IS NOT NULL AND sku IS NOT NULL
  GROUP BY po_id, sku
),
agg_receipts AS (
  -- Pre-aggregate received quantities to safely handle multiple partial deliveries per SKU
  SELECT po_id, sku, SUM(qty_received) AS qty_received
  FROM receipts
  WHERE po_id IS NOT NULL AND sku IS NOT NULL
  GROUP BY po_id, sku
),
supplier_totals AS (
  -- Join everything together, defaulting missing receipts to 0
  SELECT 
    p.month,
    p.supplier_id,
    l.qty_ordered,
    COALESCE(r.qty_received, 0) AS qty_received
  FROM clean_pos p
  JOIN agg_lines l ON p.po_id = l.po_id
  LEFT JOIN agg_receipts r ON l.po_id = r.po_id AND l.sku = r.sku
)
-- Aggregate the final totals by month and supplier
SELECT 
  month,
  supplier_id,
  SUM(qty_ordered) AS ordered_qty,
  SUM(qty_received) AS received_qty,
  -- Multiply by 1.0 to force safe decimal division
  ROUND(1.0 * SUM(qty_received) / SUM(qty_ordered), 4) AS fill_rate
FROM supplier_totals
GROUP BY month, supplier_id
ORDER BY month ASC, fill_rate DESC, supplier_id ASC;