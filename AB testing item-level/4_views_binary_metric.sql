-- Calculate the view item binary for the 30 day window after the test assignment.
SELECT
  test_assignment,
  COUNT(item_id) AS items,
  SUM(views_binary_30d) AS views_binary_30d,
  CAST(
    100 * SUM(views_binary_30d) / COUNT(item_id) AS FLOAT
  ) AS viewed_percent,
  SUM(views_30d) AS views_30d,
  SUM(views_30d) / COUNT(item_id) AS average_views_per_item_30d
FROM
  (
    SELECT
      assignments.item_id,
      assignments.test_assignment,
      MAX(
        CASE
          WHEN (
            views.event_time > assignments.test_start_date
            AND DATE_PART(
              'day',
              views.event_time - assignments.test_start_date
            ) <= 30
          ) THEN 1
          ELSE 0
        END
      ) AS views_binary_30d,
      COUNT(
        CASE
          WHEN (
            views.event_time > assignments.test_start_date
            AND DATE_PART(
              'day',
              views.event_time - assignments.test_start_date
            ) <= 30
          ) THEN views.event_id
          ELSE NULL
        END
      ) AS views_30d
    FROM
      dsv1069.final_assignments assignments
      LEFT JOIN (
        SELECT
          event_time,
          event_id,
          CAST(parameter_value AS INT) AS item_id
        FROM
          dsv1069.events
        WHERE
          event_name = 'view_item'
          AND parameter_name = 'item_id'
      ) views ON assignments.item_id = views.item_id
      AND views.event_time > assignments.test_start_date
    WHERE
      assignments.test_number = 'item_test_2'
    GROUP BY
      assignments.item_id,
      assignments.test_assignment
  ) item_level
GROUP BY
  test_assignment