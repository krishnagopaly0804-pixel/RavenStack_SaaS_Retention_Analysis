
-- Retention Validation
-- Purpose: Compare January and December active accounts
-- with current account-level churn status.
-- Note: Current churn status is not historical churn status.

WITH RECURSIVE months AS (
    SELECT DATE('2024-01-31') AS month_end

    UNION ALL

    SELECT LAST_DAY(DATE_ADD(month_end, INTERVAL 1 DAY))
    FROM months
    WHERE month_end < '2024-12-31'
),
monthly_active_accounts AS (
    SELECT DISTINCT
        m.month_end,
        s.account_id
    FROM months m
    JOIN raw_subscriptions s
        ON STR_TO_DATE(s.start_date, '%Y-%m-%d')
           <= m.month_end
       AND (
           NULLIF(TRIM(s.end_date), '') IS NULL
           OR STR_TO_DATE(s.end_date, '%Y-%m-%d')
              > m.month_end
       )
),
january_accounts AS (
    SELECT account_id
    FROM monthly_active_accounts
    WHERE month_end = '2024-01-31'
),
december_accounts AS (
    SELECT account_id
    FROM monthly_active_accounts
    WHERE month_end = '2024-12-31'
)
SELECT
    LOWER(TRIM(a.churn_flag)) AS current_account_churn_flag,
    COUNT(DISTINCT j.account_id) AS january_accounts,
    COUNT(DISTINCT d.account_id) AS active_in_december
FROM january_accounts j
JOIN raw_accounts a
    ON j.account_id = a.account_id
LEFT JOIN december_accounts d
    ON j.account_id = d.account_id
GROUP BY LOWER(TRIM(a.churn_flag))
ORDER BY current_account_churn_flag;
