
-- Step 43: Summarize account churn flags by signup cohort.
-- This compares the supplied account-level flag with cohort size.
-- It does not assume that the raw flag is a validated churn definition.

SELECT
    DATE_FORMAT(
        STR_TO_DATE(
            NULLIF(TRIM(signup_date), ''),
            '%Y-%m-%d'
        ),
        '%Y-%m'
    ) AS signup_cohort,

    COUNT(DISTINCT account_id) AS cohort_size,

    COUNT(DISTINCT CASE
        WHEN LOWER(TRIM(churn_flag)) = 'false'
            THEN account_id
    END) AS accounts_flagged_not_churned,

    COUNT(DISTINCT CASE
        WHEN LOWER(TRIM(churn_flag)) = 'true'
            THEN account_id
    END) AS accounts_flagged_churned,

    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN LOWER(TRIM(churn_flag)) = 'true'
                THEN account_id
        END)
        / NULLIF(COUNT(DISTINCT account_id), 0),
        2
    ) AS raw_account_churn_pct

FROM raw_accounts

WHERE STR_TO_DATE(
    NULLIF(TRIM(signup_date), ''),
    '%Y-%m-%d'
) IS NOT NULL

GROUP BY
    DATE_FORMAT(
        STR_TO_DATE(
            NULLIF(TRIM(signup_date), ''),
            '%Y-%m-%d'
        ),
        '%Y-%m'
    )

ORDER BY signup_cohort;
