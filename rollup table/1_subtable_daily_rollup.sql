-- Goal: create a subtable of orders per day.
SELECT
  DATE(paid_at) AS DAY,
  COUNT(DISTINCT invoice_id) AS orders,
  COUNT(DISTINCT line_item_id) AS line_items
FROM
  dsv1069.orders
GROUP BY
  DATE(paid_at)