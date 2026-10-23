-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Compare feature usage by account churn flag.
-- Limitation: Usage is not restricted to the period before churn.
-- Results are descriptive and do not establish causation.

USE saas_retention;

SELECT
    a.churn_flag AS account_churn_flag,
    f.feature_name,
    COUNT(*) AS total_usage_records,
    COUNT(DISTINCT f.subscription_id) AS subscriptions_using_feature,
    ROUND(
        AVG(CAST(NULLIF(TRIM(f.usage_count), '')
            AS DECIMAL(10,2))), 2
    ) AS avg_usage_count,
    ROUND(
        AVG(CAST(NULLIF(TRIM(f.usage_duration_secs), '')
            AS DECIMAL(10,2))), 2
    ) AS avg_usage_duration_secs
FROM raw_accounts a
JOIN raw_subscriptions s
    ON a.account_id = s.account_id
JOIN raw_feature_usage f
    ON s.subscription_id = f.subscription_id
GROUP BY
    a.churn_flag,
    f.feature_name
ORDER BY
    f.feature_name,
    a.churn_flag;
