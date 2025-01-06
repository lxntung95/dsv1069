-- Goal: Test your joins.
SELECT
  *
FROM
  dsv1069.dates_rollup
  LEFT OUTER JOIN (
    SELECT
      DATE(paid_at) AS DAY,
      COUNT(DISTINCT invoice_id) AS orders,
      COUNT(DISTINCT line_item_id) AS items_ordered
    FROM
      dsv1069.orders
    GROUP BY
      DATE(paid_at)
  ) daily_orders ON dates_rollup.date >= daily_orders.day
  AND dates_rollup.d7_ago < daily_orders.day
LIMIT 100