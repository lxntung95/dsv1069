-- Calculate the order binary for the 30 day window after the test assignment.
SELECT
  test_assignment,
  COUNT(item_id) AS items,
  SUM(orders_binary_30d) AS orders_binary_30d
FROM
  (
    SELECT
      assignments.item_id,
      assignments.test_assignment,
      MAX(
        CASE
          WHEN (
            orders.created_at > assignments.test_start_date
            AND DATE_PART(
              'day',
              orders.created_at - assignments.test_start_date
            ) <= 30
          ) THEN 1
          ELSE 0
        END
      ) AS orders_binary_30d
    FROM
      dsv1069.final_assignments assignments
      LEFT JOIN dsv1069.orders ON assignments.item_id = orders.item_id
      AND orders.created_at > assignments.test_start_date
    WHERE
      assignments.test_number = 'item_test_2'
    GROUP BY
      assignments.item_id,
      assignments.test_assignment
  ) item_level
GROUP BY
  test_assignment
LIMIT 100