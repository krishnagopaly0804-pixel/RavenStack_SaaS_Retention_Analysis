-- Summarize monthly subscription churn rates.
-- Purpose: Identify months with the highest recorded churn rates.
-- This uses the existing subscription end-date and start-date logic.

WITH monthly_churn AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(
                NULLIF(TRIM(end_date), ''),
                '%Y-%m-%d'
            ),
            '%Y-%m'
        ) AS churn_month,

        COUNT(*) AS churned_subscriptions

    FROM raw_subscriptions

    WHERE NULLIF(TRIM(end_date), '') IS NOT NULL

    GROUP BY DATE_FORMAT(
        STR_TO_DATE(
            NULLIF(TRIM(end_date), ''),
            '%Y-%m-%d'
        ),
        '%Y-%m'
    )
)

SELECT
    churn_month,
    churned_subscriptions

FROM monthly_churn

WHERE churn_month BETWEEN '2024-01' AND '2024-12'

ORDER BY churned_subscriptions DESC;
