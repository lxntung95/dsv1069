-- Makes sense to have INSERT INTO statement with the CREATE TABLE statement together.
CREATE TABLE 'view_item_events'(
  event_id VARCHAR(32) NOT NULL PRIMARY KEY,
  event_time VARCHAR(26),
  user_id INT(10),
  platform VARCHAR(10),
  item_id INT(10),
  referrer VARCHAR(17)
);

INSERT INTO
  'view_item_events'
SELECT
  event_id,
  -- clean the data format
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