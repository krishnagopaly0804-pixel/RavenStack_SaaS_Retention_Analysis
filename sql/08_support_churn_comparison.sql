-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Compare support-ticket metrics by account churn flag.
-- Limitation: Includes all tickets, regardless of timing relative to churn.
-- Results are descriptive and do not establish causation.

USE saas_retention;

SELECT
    a.churn_flag AS account_churn_flag,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    COUNT(t.ticket_id) AS total_tickets,
    ROUND(AVG(
        CAST(NULLIF(TRIM(t.resolution_time_hours), '') AS DECIMAL(10,2))
    ), 2) AS avg_resolution_hours,
    ROUND(AVG(
        CAST(NULLIF(TRIM(t.satisfaction_score), '') AS DECIMAL(10,2))
    ), 2) AS avg_satisfaction_score,
    ROUND(AVG(
        CAST(NULLIF(TRIM(t.first_response_time_minutes), '') AS DECIMAL(10,2))
    ), 2) AS avg_first_response_minutes
FROM raw_accounts a
LEFT JOIN raw_support_tickets t
    ON a.account_id = t.account_id
GROUP BY a.churn_flag
ORDER BY a.churn_flag;
