-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Perform initial data quality checks.
-- Note: These queries inspect data; they do not modify source records.

USE saas_retention;

-- 1. Check row counts across all five imported tables.
SELECT 'raw_accounts' AS table_name, COUNT(*) AS total_rows
FROM raw_accounts
UNION ALL
SELECT 'raw_subscriptions', COUNT(*)
FROM raw_subscriptions
UNION ALL
SELECT 'raw_churn_events', COUNT(*)
FROM raw_churn_events
UNION ALL
SELECT 'raw_feature_usage', COUNT(*)
FROM raw_feature_usage
UNION ALL
SELECT 'raw_support_tickets', COUNT(*)
FROM raw_support_tickets;

-- 2. Inspect account records.
SELECT *
FROM raw_accounts
LIMIT 10;

-- 3. Inspect subscription records.
SELECT *
FROM raw_subscriptions
LIMIT 10;

-- 4. Inspect churn event records.
SELECT *
FROM raw_churn_events
LIMIT 10;

-- 5. Inspect feature usage records.
SELECT *
FROM raw_feature_usage
LIMIT 10;

-- 6. Inspect support ticket records.
SELECT *
FROM raw_support_tickets
LIMIT 10;
