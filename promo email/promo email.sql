-- Add in any extra filtering that may make this email better.
SELECT
  -- Take into account merged accounts by using COALESCE if parent_user_id is not NULL.
  COALESCE(users.parent_user_id, users.id) AS user_id,
  users.email_address,
  items.id AS item_id,
  items.name AS item_name,
  items.category AS item_category
FROM
  (
    SELECT
      user_id,
      item_id,
      event_time,
      ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY
          event_time DESC
      ) AS view_number
    FROM
      dsv1069.view_item_events
    WHERE
      -- Do not account for view_item events more than 1 year old
      event_time > '2017-01-01'
  ) recent_views
  JOIN dsv1069.users ON users.id = recent_views.user_id
  JOIN dsv1069.items ON items.id = recent_views.item_id
  LEFT JOIN dsv1069.orders ON orders.item_id = recent_views.item_id -- Do not send email notification to customer who already purchased their viewed item.
  AND orders.user_id = recent_views.user_id
WHERE
  view_number = 1
  AND users.deleted_at IS NOT NULL
  AND orders.item_id IS NULL -- Remove email notification to customers who already ordered their viewed item.
LIMIT 100