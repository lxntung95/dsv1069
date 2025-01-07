NAME

    dsv1069

LANGUAGE

    SQL

DESCRIPTION

    dsv1069 is a database for an e-commerce firm containing various tables (users, orders, events, etc.). There are various queries in this repository for different analytical purposes.

    counting new users: count the number of new users added per day accounting for deleted and merged users, accounting for when users were deleted not created.

    create clean view_item_events table: create a subtable of the events table with clean data, then query a snapshot table accounting for backfilling.

    rollup table: create a subtable of weekly orders on a rolling basis.

    promo email: create a list of users who should receive a promo email notification that have viewed the item recently and does not send to customers who already purchased their viewed item.

    AB testing item-level:
    - Compute the lifts in metrics and p-values for the binary metrics (30 day orders binary and 30 day views binary) using a 95% confidence interval.
    - Orders Binary Conclusion: There was a detriment of -1% in the orders between the control and treatment groups. But with a p-value of 0.88, the results are not statistically significant. Therefore, we cannot reject the null hypothesis and cannot conclude there is a statistically significant difference in item orders between the 2 groups.
    - Views Binary Conclusion: There was an improvement of +2.6% in the item views between the control and treatment groups. However, with a p-value of 0.2, the results are not statistically significant. Therefore, we cannot reject the null hypothesis and cannot conclude there is a statistically significant difference in item views between the 2 groups.

SUPPORT

    Visit my GitHub website for the latest scripts and downloads:
    https://github.com/lxntung95
