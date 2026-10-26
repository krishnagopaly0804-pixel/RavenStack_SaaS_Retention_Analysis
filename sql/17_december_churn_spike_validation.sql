-- Investigate subscriptions ending in December 2024.
-- Purpose: Compare ended subscription count with unique account count.
-- This helps determine whether multiple ended subscriptions
-- belong to the same account.

SELECT
    COUNT(*) AS ended_subscription_count,

    COUNT(DISTINCT subscription_id)
        AS unique_subscription_count,

    COUNT(DISTINCT account_id)
        AS unique_account_count,

    MIN(
        STR_TO_DATE(
            NULLIF(TRIM(end_date), ''),
            '%Y-%m-%d'
        )
    ) AS first_end_date,

    MAX(
        STR_TO_DATE(
            NULLIF(TRIM(end_date), ''),
            '%Y-%m-%d'
        )
    ) AS last_end_date

FROM raw_subscriptions

WHERE STR_TO_DATE(
    NULLIF(TRIM(end_date), ''),
    '%Y-%m-%d'
) >= '2024-12-01'

AND STR_TO_DATE(
    NULLIF(TRIM(end_date), ''),
    '%Y-%m-%d'
) < '2025-01-01';
