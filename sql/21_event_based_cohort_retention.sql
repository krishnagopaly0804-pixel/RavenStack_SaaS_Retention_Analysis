-- Purpose:
-- Calculate event-based cohort retention.
--
-- Cohort:
-- Accounts grouped by signup month.
--
-- Retained account:
-- An account with no non-reactivation churn event
-- from signup date through reporting month-end.
--
-- Month 0:
-- Signup month, measured at month-end.
--
-- Reactivation events do not reverse a previous churn event.
-- ============================================================

WITH RECURSIVE calendar AS (

    -- Start reporting calendar in January 2023
    SELECT DATE('2023-01-01') AS month_start

    UNION ALL

    -- Generate one month at a time
    SELECT DATE_ADD(month_start, INTERVAL 1 MONTH)
    FROM calendar
    WHERE month_start < DATE('2024-12-01')
),

accounts AS (
    SELECT
        account_id,

        STR_TO_DATE(
            NULLIF(TRIM(signup_date), ''),
            '%Y-%m-%d'
        ) AS signup_dt,

        CAST(
            DATE_FORMAT(
                STR_TO_DATE(
                    NULLIF(TRIM(signup_date), ''),
                    '%Y-%m-%d'
                ),
                '%Y-%m-01'
            ) AS DATE
        ) AS cohort_month

    FROM raw_accounts
),

-- Find each account's first qualifying churn event.
first_churn AS (
    SELECT
        a.account_id,
        MIN(
            STR_TO_DATE(
                NULLIF(TRIM(e.churn_date), ''),
                '%Y-%m-%d'
            )
        ) AS first_churn_dt

    FROM accounts a

    JOIN raw_churn_events e
        ON e.account_id = a.account_id

    WHERE
        LOWER(TRIM(e.is_reactivation)) IN ('false', '0')

        AND STR_TO_DATE(
            NULLIF(TRIM(e.churn_date), ''),
            '%Y-%m-%d'
        ) >= a.signup_dt

    GROUP BY a.account_id
),

-- Calculate original size of each signup cohort.
cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT account_id) AS cohort_size

    FROM accounts
    WHERE signup_dt IS NOT NULL

    GROUP BY cohort_month
),

-- Generate reporting months for each cohort.
cohort_snapshots AS (
    SELECT
        cs.cohort_month,
        c.month_start,

        TIMESTAMPDIFF(
            MONTH,
            cs.cohort_month,
            c.month_start
        ) AS cohort_age_month,

        cs.cohort_size

    FROM cohort_sizes cs

    JOIN calendar c
        ON c.month_start >= cs.cohort_month
        AND c.month_start <= DATE_ADD(
            cs.cohort_month,
            INTERVAL 12 MONTH
        )
),

retention_metrics AS (
    SELECT
        s.cohort_month,
        s.month_start,
        s.cohort_age_month,
        s.cohort_size,

        COUNT(DISTINCT CASE
            WHEN fc.first_churn_dt IS NULL
              OR fc.first_churn_dt > LAST_DAY(s.month_start)
            THEN a.account_id
        END) AS retained_accounts

    FROM cohort_snapshots s

    JOIN accounts a
        ON a.cohort_month = s.cohort_month

    LEFT JOIN first_churn fc
        ON fc.account_id = a.account_id

    GROUP BY
        s.cohort_month,
        s.month_start,
        s.cohort_age_month,
        s.cohort_size
)

SELECT
    DATE_FORMAT(cohort_month, '%Y-%m') AS signup_cohort,

    cohort_age_month,

    DATE_FORMAT(month_start, '%Y-%m') AS reporting_month,

    cohort_size,

    retained_accounts,

    ROUND(
        retained_accounts * 100.0 /
        NULLIF(cohort_size, 0),
        2
    ) AS retention_rate_pct

FROM retention_metrics

ORDER BY
    cohort_month,
    cohort_age_month;
