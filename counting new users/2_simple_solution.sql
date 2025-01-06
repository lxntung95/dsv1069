-- Count only new users created each day.
SELECT
  DATE(created_at) AS created_day,
  COUNT(*) AS users
FROM
  dsv1069.users
GROUP BY
  DATE(created_at)