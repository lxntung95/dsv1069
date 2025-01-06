-- Putting it all together. Accounts for the NET added users.
SELECT
  new.day,
  new.new_added_users,
  COALESCE(deleted.deleted_users, 0) AS deleted_users,
  -- need COALESCE to replace NULL with 0
  COALESCE(merged.merged_users, 0) AS merged_users,
  (
    new.new_added_users - COALESCE(deleted.deleted_users, 0) - COALESCE(merged.merged_users, 0)
  ) AS net_added_users
FROM
  (
    SELECT
      DATE(created_at) AS DAY,
      COUNT(*) AS new_added_users
    FROM
      dsv1069.users
    GROUP BY
      DATE(created_at)
  ) new
  LEFT JOIN (
    -- do instead of INNER JOIN because want all days, not just where deleted days match with new days
    SELECT
      DATE(deleted_at) AS DAY,
      COUNT(*) AS deleted_users
    FROM
      dsv1069.users
    WHERE
      deleted_at IS NOT NULL
    GROUP BY
      DATE(deleted_at)
  ) deleted -- only care about when users were deleted, not when they were created
  ON new.day = deleted.day -- line up the new users added with old deleted users
  LEFT JOIN (
    SELECT
      DATE(merged_at) AS DAY,
      COUNT(*) AS merged_users
    FROM
      dsv1069.users
    WHERE
      id <> parent_user_id
      AND parent_user_id IS NOT NULL
    GROUP BY
      DATE(merged_at)
  ) merged ON merged.day = new.day
ORDER BY
  new.day