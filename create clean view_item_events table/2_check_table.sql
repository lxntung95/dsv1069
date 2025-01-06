DESCRIBE view_item_events_1;
-- event_id should be a Primary Key and have no NULLs
-- event_time should be a date
-- item_id should be an integer

SELECT
  *
FROM
  view_item_events_1
LIMIT
  10;

-- SHOULD NOT DO WITH A TABLE NOT THE OWNER OF
DROP TABLE view_item_events_1; -- erases the table from the database