-- December 2024 Churn Reason Analysis
-- Purpose: Identify the most frequently recorded reasons
-- among non-reactivation churn events in December 2024.
-- Note: Event percentages are not customer churn rates.

SELECT
    LOWER(TRIM(reason_code)) AS churn_reason,
    COUNT(*) AS churn_events,
    COUNT(DISTINCT account_id) AS unique_accounts,
    ROUND(
        100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER (),
        2
    ) AS event_percentage
FROM raw_churn_events
WHERE LOWER(TRIM(is_reactivation)) = 'false'
  AND STR_TO_DATE(churn_date, '%Y-%m-%d') >= '2024-12-01'
  AND STR_TO_DATE(churn_date, '%Y-%m-%d') < '2025-01-01'
GROUP BY LOWER(TRIM(reason_code))
ORDER BY churn_events DESC;
