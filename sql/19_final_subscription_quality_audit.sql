-- Final subscription churn consistency audit.
-- Purpose: Check whether subscription churn flags match end-date status.
-- This validates data consistency; it does not define account churn.

SELECT
    COUNT(*) AS total_subscription_rows,

    COUNT(DISTINCT subscription_id)
        AS unique_subscription_ids,

    COUNT(DISTINCT account_id)
        AS accounts_with_subscriptions,

    SUM(
        CASE
            WHEN LOWER(TRIM(churn_flag)) = 'true'
                THEN 1 ELSE 0
        END
    ) AS subscriptions_flagged_churned,

    SUM(
        CASE
            WHEN LOWER(TRIM(churn_flag)) = 'false'
                THEN 1 ELSE 0
        END
    ) AS subscriptions_flagged_not_churned,

    SUM(
        CASE
            WHEN LOWER(TRIM(churn_flag)) = 'true'
             AND NULLIF(TRIM(end_date), '') IS NULL
                THEN 1 ELSE 0
        END
    ) AS churn_flag_true_missing_end_date,

    SUM(
        CASE
            WHEN LOWER(TRIM(churn_flag)) = 'false'
             AND NULLIF(TRIM(end_date), '') IS NOT NULL
                THEN 1 ELSE 0
        END
    ) AS churn_flag_false_with_end_date

FROM raw_subscriptions;
