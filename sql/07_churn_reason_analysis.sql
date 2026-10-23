-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Analyse the most common non-reactivation churn reasons.
-- Note: Percentages represent events, not customer churn rates.

USE saas_retention;

SELECT
    LOWER(TRIM(reason_code)) AS churn_reason,
    COUNT(*) AS total_events,
    COUNT(DISTINCT account_id) AS unique_accounts,
    ROUND(
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(*)
            FROM raw_churn_events
            WHERE LOWER(TRIM(is_reactivation)) IN ('false', '0')
        ),
        2
    ) AS percentage_of_non_reactivation_events
FROM raw_churn_events
WHERE LOWER(TRIM(is_reactivation)) IN ('false', '0')
GROUP BY LOWER(TRIM(reason_code))
ORDER BY total_events DESC;
