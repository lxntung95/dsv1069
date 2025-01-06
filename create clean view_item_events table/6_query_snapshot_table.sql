-- Snapshot Table: provides a picture of what the Users table looks like daily.
-- Labeling data will help automate the process.
--
-- New Columns in Snapshot Table:
-- created_today, is_deleted, deleted_today, has_ever_ordered, ordered_today, date
-- 
-- Dependencies:
-- Upstream: Users table, Orders table
-- Downstream: Dashboard tables, Prediction scores computed using these features
-- 
-- Backfilling: want to make sure it works for all days in the past.
--
-- MODE: this is not available to do in the free version.
--
-- Liquid Tag: assign a variable in Mode

SELECT
  users.id AS user_id,
  CASE
    WHEN users.created_at = '2018-01-01' THEN 1
    ELSE 0
  END AS created_today,
  CASE
    WHEN users.deleted_at <= '2018-01-01' THEN 1
    ELSE 0
  END AS is_deleted,
  CASE
    WHEN users.deleted_at = '2018-01-01' THEN 1
    ELSE 0
  END AS is_deleted_today,
  CASE
    WHEN users_with_orders.user_id IS NOT NULL THEN 1
    ELSE 0
  END AS has_ever_ordered,
  CASE
    WHEN users_with_orders_today.user_id IS NOT NULL THEN 1
    ELSE 0
  END AS ordered_today,
  '2018-01-01' AS ds
FROM
  dsv1069.users users
  LEFT JOIN (
    SELECT
      DISTINCT user_id
    FROM
      dsv1069.orders
    WHERE
      created_at <= '2018-01-01'
  ) users_with_orders ON users_with_orders.user_id = users.id
  LEFT JOIN(
    SELECT
      DISTINCT user_id
    FROM
      dsv1069.orders
    WHERE
      created_at = '2018-01-01'
  ) users_with_orders_today ON users_with_orders_today.user_id = users.id
WHERE
  created_at <= '2018-01-01'