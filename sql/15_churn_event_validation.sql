-- Compare churned subscriptions with non-reactivation churn events.
-- Purpose: Identify accounts with ended subscriptions but no matching
-- non-reactivation churn event.
-- Note: This is an account-level comparison, not a subscription-level match.

SELECT
    COUNT(DISTINCT s.account_id) AS accounts_with_ended_subscriptions,

    COUNT(DISTINCT CASE
        WHEN e.account_id IS NOT NULL
            THEN s.account_id
    END) AS accounts_with_churn_events,

    COUNT(DISTINCT CASE
        WHEN e.account_id IS NULL
            THEN s.account_id
    END) AS accounts_without_churn_events

FROM raw_subscriptions AS s

LEFT JOIN (
    SELECT DISTINCT account_id
    FROM raw_churn_events
    WHERE LOWER(TRIM(is_reactivation)) = 'false'
) AS e
    ON s.account_id = e.account_id

WHERE NULLIF(TRIM(s.end_date), '') IS NOT NULL;
