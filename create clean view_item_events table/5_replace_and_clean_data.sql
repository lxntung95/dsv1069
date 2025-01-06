-- Clear out the table and just put the new stuff in, will not make duplicate rows if table already has it.
REPLACE INTO
  'view_item_events'
SELECT
  event_id,
  TIMESTAMP(event_time),
  user_id,
  platform,
  MAX(
    CASE
      WHEN parameter_name = 'item_id' THEN parameter_value
      ELSE NULL
    END
  ) AS item_id,
  MAX(
    CASE
      WHEN parameter_name = 'referrer' THEN parameter_value
      ELSE NULL
    END
  ) AS referrer
FROM
  dsv1069.events
WHERE
  event_name = 'view_item'
GROUP BY
  event_id,
  event_time,
  user_id,
  platform
LIMIT 100