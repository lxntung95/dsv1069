SELECT
  DATE(dates_rollup.date),
  COALESCE(SUM(orders), 0) AS orders,
  COALESCE(SUM(items_ordered), 0) AS items_ordered,
  -- how many rows are collapsed into one rolling date week
  COUNT(*) AS ROWS
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
GROUP BY
  DATE(dates_rollup.date)
LIMIT 100