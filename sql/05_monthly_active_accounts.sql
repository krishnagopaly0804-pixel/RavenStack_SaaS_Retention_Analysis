-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Calculate monthly active subscriptions and accounts.
-- Note: Validate date formats and business rules before interpreting results.

USE saas_retention;

-- Build a month-end reporting calendar for January–December 2024.
WITH RECURSIVE months AS (
    SELECT DATE('2024-01-31') AS month_end

    UNION ALL

    SELECT LAST_DAY(DATE_ADD(month_end, INTERVAL 1 DAY))
    FROM months
    WHERE month_end < '2024-12-31'
)

SELECT
    DATE_FORMAT(m.month_end, '%Y-%m') AS reporting_month,

    COUNT(DISTINCT s.subscription_id) AS active_subscriptions,

    COUNT(DISTINCT s.account_id) AS active_accounts

FROM months m

LEFT JOIN raw_subscriptions s
    ON STR_TO_DATE(s.start_date, '%Y-%m-%d') <= m.month_end
   AND (
        s.end_date IS NULL
        OR TRIM(s.end_date) = ''
        OR STR_TO_DATE(s.end_date, '%Y-%m-%d') > m.month_end
   )

GROUP BY m.month_end
ORDER BY m.month_end;
