-- Does not include deleted or merged users.
-- New issue: dramatic shift in the graph if a bunch of accounts get deleted. Need to be clear when deleting happens.
SELECT
  DATE(created_at) AS created_day,
  COUNT(*) AS users
FROM
  dsv1069.users
WHERE
  deleted_at IS NULL -- removes accounts that get deleted
  AND (
    id <> parent_user_id -- removes accounts that get merged
    OR parent_user_id IS NULL -- accounts for when parent_user_id is NULL and not equal to the id
  )
GROUP BY
  DATE(created_at)
LIMIT 100