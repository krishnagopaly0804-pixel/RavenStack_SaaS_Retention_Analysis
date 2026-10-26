-- Count subscriptions ending on each day in December 2024.
-- Purpose: Identify dates with unusually high numbers of endings.
-- This counts subscription records, not unique customers.

SELECT
    DATE(
        STR_TO_DATE(
            NULLIF(TRIM(end_date), ''),
            '%Y-%m-%d'
        )
    ) AS end_date,

    COUNT(*) AS ended_subscriptions,

    COUNT(DISTINCT account_id) AS unique_accounts

FROM raw_subscriptions

WHERE STR_TO_DATE(
    NULLIF(TRIM(end_date), ''),
    '%Y-%m-%d'
) >= '2024-12-01'

AND STR_TO_DATE(
    NULLIF(TRIM(end_date), ''),
    '%Y-%m-%d'
) < '2025-01-01'

GROUP BY DATE(
    STR_TO_DATE(
        NULLIF(TRIM(end_date), ''),
        '%Y-%m-%d'
    )
)

ORDER BY ended_subscriptions DESC, end_date;
