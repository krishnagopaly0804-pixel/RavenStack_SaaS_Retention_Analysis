-- Purpose: Measure month-end active retention by first-subscription cohort.
-- Cohort definition: Month of an account's first recorded subscription start.
-- Activity definition: Account has at least one subscription active at month-end.
-- Note: Month-end snapshots do not prove continuous activity between month-ends.

WITH RECURSIVE months AS (
    SELECT LAST_DAY('2024-01-01') AS month_end

    UNION ALL

    SELECT LAST_DAY(DATE_ADD(month_end, INTERVAL 1 DAY))
    FROM months
    WHERE month_end < '2024-12-31'
),

first_subscription AS (
    SELECT
        account_id,
        MIN(STR_TO_DATE(start_date, '%Y-%m-%d')) AS first_start_date
    FROM raw_subscriptions
    WHERE STR_TO_DATE(start_date, '%Y-%m-%d') IS NOT NULL
    GROUP BY account_id
),

cohorts AS (
    SELECT
        account_id,
        first_start_date,
        DATE_FORMAT(first_start_date, '%Y-%m') AS cohort_month
    FROM first_subscription
    WHERE first_start_date >= '2024-01-01'
      AND first_start_date < '2025-01-01'
),

cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT account_id) AS cohort_accounts
    FROM cohorts
    GROUP BY cohort_month
),

activity AS (
    SELECT
        c.cohort_month,
        c.account_id,
        m.month_end,
        COUNT(s.subscription_id) AS active_subscriptions
    FROM cohorts c
    JOIN months m
        ON m.month_end >= LAST_DAY(c.first_start_date)
    LEFT JOIN raw_subscriptions s
        ON s.account_id = c.account_id
       AND STR_TO_DATE(s.start_date, '%Y-%m-%d') <= m.month_end
       AND (
           NULLIF(TRIM(s.end_date), '') IS NULL
           OR STR_TO_DATE(s.end_date, '%Y-%m-%d') > m.month_end
       )
    GROUP BY
        c.cohort_month,
        c.account_id,
        m.month_end
)

SELECT
    a.cohort_month,
    cs.cohort_accounts,
    DATE_FORMAT(a.month_end, '%Y-%m') AS reporting_month,
    TIMESTAMPDIFF(
        MONTH,
        STR_TO_DATE(CONCAT(a.cohort_month, '-01'), '%Y-%m-%d'),
        a.month_end
    ) AS cohort_age_month,
    SUM(a.active_subscriptions > 0) AS active_accounts,
    ROUND(
        100.0 * SUM(a.active_subscriptions > 0)
        / cs.cohort_accounts,
        2
    ) AS month_end_retention_pct
FROM activity a
JOIN cohort_sizes cs
    ON a.cohort_month = cs.cohort_month
GROUP BY
    a.cohort_month,
    cs.cohort_accounts,
    a.month_end
ORDER BY
    a.cohort_month,
    a.month_end;
