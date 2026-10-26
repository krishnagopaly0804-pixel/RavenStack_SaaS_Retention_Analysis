
-- Step 36: Calculate monthly subscription churn rates for 2024.
-- Denominator: subscriptions active at the start of each month.
-- Numerator: subscriptions ending during that month.
-- This is a subscription churn rate, not an account churn rate.

WITH months AS (
    SELECT '2024-01-01' AS month_start
    UNION ALL SELECT '2024-02-01'
    UNION ALL SELECT '2024-03-01'
    UNION ALL SELECT '2024-04-01'
    UNION ALL SELECT '2024-05-01'
    UNION ALL SELECT '2024-06-01'
    UNION ALL SELECT '2024-07-01'
    UNION ALL SELECT '2024-08-01'
    UNION ALL SELECT '2024-09-01'
    UNION ALL SELECT '2024-10-01'
    UNION ALL SELECT '2024-11-01'
    UNION ALL SELECT '2024-12-01'
),

subscription_dates AS (
    SELECT
        subscription_id,
        STR_TO_DATE(
            NULLIF(TRIM(start_date), ''),
            '%Y-%m-%d'
        ) AS start_dt,
        STR_TO_DATE(
            NULLIF(TRIM(end_date), ''),
            '%Y-%m-%d'
        ) AS end_dt
    FROM raw_subscriptions
)

SELECT
    DATE_FORMAT(m.month_start, '%Y-%m') AS churn_month,

    SUM(
        CASE
            WHEN s.start_dt < m.month_start
             AND (s.end_dt IS NULL OR s.end_dt >= m.month_start)
            THEN 1 ELSE 0
        END
    ) AS subscriptions_active_at_start,

    SUM(
        CASE
            WHEN s.end_dt >= m.month_start
             AND s.end_dt < DATE_ADD(m.month_start, INTERVAL 1 MONTH)
            THEN 1 ELSE 0
        END
    ) AS subscriptions_ended_during_month,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN s.end_dt >= m.month_start
                 AND s.end_dt < DATE_ADD(m.month_start, INTERVAL 1 MONTH)
                THEN 1 ELSE 0
            END
        ) /
        NULLIF(
            SUM(
                CASE
                    WHEN s.start_dt < m.month_start
                     AND (s.end_dt IS NULL OR s.end_dt >= m.month_start)
                    THEN 1 ELSE 0
                END
            ),
            0
        ),
        2
    ) AS monthly_subscription_churn_rate_pct

FROM months AS m
CROSS JOIN subscription_dates AS s

GROUP BY m.month_start
ORDER BY m.month_start;

