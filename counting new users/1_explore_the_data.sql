/* Know your data well.
 Each user has a unique id.
 created_at: date when account was created.
 deleted_at: some users have a deleted date.
 merged_at: some users have a merged_at date where an id was merged into a parent_user_id.
 - see pairs of accounts where two different ids are merged into a parent_user_id
 */
SELECT
  id,
  parent_user_id,
  merged_at
FROM
  dsv1069.users
ORDER BY
  parent_user_id ASC
LIMIT 100