-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Explore subscription churn indicators and churn events.
-- These queries are read-only and do not modify source data.

USE saas_retention;

-- 1. Check subscription counts by source churn flag.
SELECT
    LOWER(TRIM(churn_flag)) AS churn_flag,
    COUNT(*) AS total_subscriptions
FROM raw_subscriptions
GROUP BY LOWER(TRIM(churn_flag))
ORDER BY churn_flag;

-- 2. Compare subscription churn flags with end-date availability.
SELECT
    LOWER(TRIM(churn_flag)) AS churn_flag,
    CASE
        WHEN end_date IS NULL OR TRIM(end_date) = '' THEN 'Missing end date'
        ELSE 'End date present'
    END AS end_date_status,
    COUNT(*) AS total_subscriptions
FROM raw_subscriptions
GROUP BY
    LOWER(TRIM(churn_flag)),
    CASE
        WHEN end_date IS NULL OR TRIM(end_date) = '' THEN 'Missing end date'
        ELSE 'End date present'
    END
ORDER BY churn_flag, end_date_status;

-- 3. Review churn events by reason code.
SELECT
    COALESCE(NULLIF(TRIM(reason_code), ''), 'Unknown') AS reason_code,
    COUNT(*) AS total_events
FROM raw_churn_events
GROUP BY COALESCE(NULLIF(TRIM(reason_code), ''), 'Unknown')
ORDER BY total_events DESC;

-- 4. Separate churn events from reactivation events.
SELECT
    LOWER(TRIM(is_reactivation)) AS is_reactivation,
    COUNT(*) AS total_events
FROM raw_churn_events
GROUP BY LOWER(TRIM(is_reactivation))
ORDER BY is_reactivation;

-- 5. Review churn events by month.
-- This assumes churn_date contains a date in YYYY-MM-DD format.
SELECT
    DATE_FORMAT(STR_TO_DATE(churn_date, '%Y-%m-%d'), '%Y-%m')
        AS event_month,
    COUNT(*) AS total_events
FROM raw_churn_events
WHERE STR_TO_DATE(churn_date, '%Y-%m-%d') IS NOT NULL
GROUP BY DATE_FORMAT(STR_TO_DATE(churn_date, '%Y-%m-%d'), '%Y-%m')
ORDER BY event_month;
