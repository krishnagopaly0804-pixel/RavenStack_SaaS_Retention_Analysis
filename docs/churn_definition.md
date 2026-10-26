# RavenStack SaaS Retention Analysis — Churn Definition

## 1. Subscription Churn

For this analysis, a subscription is considered churned when its recorded `churn_flag` is `true` and its `end_date` is populated.

The raw dataset contains:

- Total subscriptions: 5,000
- Churned subscriptions: 486
- Non-churned subscriptions: 4,514

All 486 churned subscriptions have an end date on or before December 31, 2024. The remaining 4,514 subscriptions have no recorded end date.

## 2. Account Churn

An account is considered churned at a reporting cutoff only when it has no subscriptions active at that cutoff.

A subscription is treated as active at the cutoff when:

- Its start date is on or before the reporting date; and
- Its end date is blank or later than the reporting date.

## 3. Data-Quality Finding

The dataset contains 500 accounts:

- 390 accounts have `churn_flag = false`.
- 110 accounts have `churn_flag = true`.

However, all 500 accounts have at least one subscription marked `churn_flag = false`. Therefore, the account-level churn flag does not directly establish that an account has lost all active subscriptions.

## 4. Reporting Limitation

The account-level churn rate should not be finalized until the relationship between account churn flags, subscription records, and the reporting cutoff has been validated.

Subscription churn and account churn must be reported as separate metrics. A churned subscription does not necessarily mean the entire account has churned.

Churn-event history should also be treated separately because a recorded event does not, by itself, prove that an account has permanently lost all active subscriptions.
