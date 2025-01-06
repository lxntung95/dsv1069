-- Counts the number of deleted accounts by day.
SELECT
  DATE(deleted_at) AS deleted_day,
  COUNT(*) AS deleted_users
FROM
  dsv1069.users
WHERE
  deleted_at IS NOT NULL
GROUP BY
  DATE(deleted_at)