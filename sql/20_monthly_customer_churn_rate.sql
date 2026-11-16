-- ============================================================
-- Project: RavenStack SaaS Retention Analysis
-- File: 20_monthly_customer_churn_rate.sql
-- Purpose:
-- Calculate monthly customer churn and reactivation metrics.
--
-- Customer churn:
-- Distinct eligible accounts with at least one
-- non-reactivation event during the month.
--
-- Reactivation:
-- Distinct eligible accounts with at least one
-- reactivation event during the month.
--
-- Eligibility:
-- Account signup date must be before the month begins.
-- ============================================================

WITH RECURSIVE months AS (
    SELECT DATE('2023-01-01') AS month_start

    UNION ALL

    SELECT DATE_ADD(month_start, INTERVAL 1 MONTH)
    FROM months
    WHERE month_start < DATE('2024-12-01')
),

accounts AS (
    SELECT
        account_id,
        STR_TO_DATE(
            NULLIF(TRIM(signup_date), ''),
            '%Y-%m-%d'
        ) AS signup_dt
    FROM raw_accounts
),

events AS (
    SELECT
        account_id,
        STR_TO_DATE(
            NULLIF(TRIM(churn_date), ''),
            '%Y-%m-%d'
        ) AS churn_dt,
        LOWER(TRIM(is_reactivation)) AS reactivation_status
    FROM raw_churn_events
),

-- One row per account per event month.
account_month_events AS (
    SELECT
        DATE_FORMAT(churn_dt, '%Y-%m-01') AS month_start,
        account_id,

        MAX(
            CASE
                WHEN reactivation_status IN ('false', '0')
                THEN 1 ELSE 0
            END
        ) AS has_non_reactivation,

        MAX(
            CASE
                WHEN reactivation_status IN ('true', '1')
                THEN 1 ELSE 0
            END
        ) AS has_reactivation

    FROM events
    WHERE churn_dt IS NOT NULL
    GROUP BY
        DATE_FORMAT(churn_dt, '%Y-%m-01'),
        account_id
),

monthly_metrics AS (
    SELECT
        m.month_start,

        COUNT(DISTINCT a.account_id) AS eligible_accounts,

        COUNT(DISTINCT CASE
            WHEN ame.has_non_reactivation = 1
            THEN a.account_id
        END) AS churned_accounts,

        COUNT(DISTINCT CASE
            WHEN ame.has_reactivation = 1
            THEN a.account_id
        END) AS reactivated_accounts,

        COUNT(DISTINCT CASE
            WHEN ame.has_non_reactivation = 1
             AND ame.has_reactivation = 1
            THEN a.account_id
        END) AS accounts_with_both_event_types

    FROM months m

    LEFT JOIN accounts a
        ON a.signup_dt < m.month_start

    LEFT JOIN account_month_events ame
        ON ame.account_id = a.account_id
        AND ame.month_start = DATE_FORMAT(m.month_start, '%Y-%m-01')

    GROUP BY m.month_start
)

SELECT
    DATE_FORMAT(month_start, '%Y-%m') AS churn_month,
    eligible_accounts,
    churned_accounts,

    ROUND(
        churned_accounts * 100.0 /
        NULLIF(eligible_accounts, 0),
        2
    ) AS customer_churn_rate_pct,

    reactivated_accounts,
    accounts_with_both_event_types

FROM monthly_metrics
ORDER BY month_start;
