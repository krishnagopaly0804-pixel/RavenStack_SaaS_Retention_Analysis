-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Analyse monthly non-reactivation churn events.
-- Note: Event counts are not churn rates.

USE saas_retention;

SELECT
    DATE_FORMAT(
        STR_TO_DATE(churn_date, '%Y-%m-%d'),
        '%Y-%m'
    ) AS churn_month,
    COUNT(*) AS non_reactivation_events,
    COUNT(DISTINCT account_id) AS unique_accounts
FROM raw_churn_events
WHERE LOWER(TRIM(is_reactivation)) IN ('false', '0')
GROUP BY DATE_FORMAT(
    STR_TO_DATE(churn_date, '%Y-%m-%d'),
    '%Y-%m'
)
ORDER BY churn_month;
