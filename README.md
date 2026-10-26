# RavenStack SaaS Retention Analysis

## Project Overview

This project investigates customer retention, subscription churn, churn events, recorded cancellation reasons, feature usage, support-ticket patterns, and signup cohorts using SQL and MySQL Workbench.

The objective is to evaluate available churn signals, identify data-quality limitations, and develop practical recommendations for improving customer retention.

## Business Objectives

- Distinguish account churn, subscription churn, and churn events.
- Analyze monthly churn-event trends and recorded cancellation reasons.
- Examine month-end subscription activity by signup cohort.
- Explore support-ticket and feature-usage patterns across churn statuses.
- Validate subscription records, date relationships, and conflicting status fields.
- Recommend evidence-based customer-retention actions.

## Tools and Technologies

- **MySQL:** Relational data analysis and querying
- **MySQL Workbench:** SQL execution and result validation
- **SQL:** Joins, aggregations, common table expressions, date functions, and data-quality checks
- **GitHub:** Source control, documentation, and project evidence

## Dataset Overview

The analysis uses five raw source tables.

| Table | Description |
|---|---|
| `raw_accounts` | Account details, signup dates, plan tiers, and account churn flags |
| `raw_subscriptions` | Subscription dates, revenue fields, plan changes, and subscription churn flags |
| `raw_churn_events` | Recorded churn reasons, event dates, and reactivation indicators |
| `raw_feature_usage` | Feature usage counts, duration, and errors |
| `raw_support_tickets` | Support priorities, response and resolution times, satisfaction, and escalations |

The original data is retained in raw tables to support investigation and validation.

## Analysis Areas

1. Raw schema inspection and data-quality checks
2. Subscription churn and account-status validation
3. Monthly active subscription and account analysis
4. Monthly churn-event trends
5. Churn-reason analysis, including December 2024
6. Support-ticket and feature-usage comparisons
7. Signup-cohort and month-end activity analysis
8. Monthly subscription-ending and exploratory churn-rate analysis
9. Subscription quality audits and churn-event validation
10. Business insights and retention recommendations

## Key Findings

### Account and subscription data

- The dataset contains **500 accounts**.
- **110 accounts (22%)** have `churn_flag = true` in the raw account table. This is a raw-flag percentage, not a validated account-churn rate.
- The subscription table contains **5,000 records** and **5,000 distinct subscription IDs**.
- **486 subscriptions** are marked as churned, while **4,514** are marked as non-churned.
- The final subscription quality audit found that all 486 churn-flagged subscriptions have end dates and all 4,514 non-churn-flagged subscriptions have blank end dates.

### Churn events and recorded reasons

- The dataset contains **600 churn events**, including reactivation events.
- There are **539 non-reactivation churn events**.
- Features, support, and budget are the three most frequently recorded reason categories across those events.
- December 2024 recorded **106 non-reactivation churn events across 87 unique accounts**. Budget was the most frequently recorded reason that month.

Recorded reasons are descriptive customer-feedback categories; they do not establish causation.

### Subscription endings

- There are **486 subscriptions with recorded end dates**.
- **193 subscriptions across 149 unique accounts** ended in December 2024.
- The concentration of subscription endings in December warrants investigation. Billing cycles, renewal dates, and end-date conventions should be checked before drawing conclusions about the cause.

### Cohort analysis

- The dataset contains **500 accounts across 24 monthly signup cohorts**.
- Raw account churn flags vary across cohorts.
- A previous month-end activity query reported 100% active accounts across all cohorts. Because every account has at least one subscription marked as non-churned, this result should not be interpreted as confirmed 100% customer retention.

## SQL Analysis Evidence

SQL scripts and their results can be reviewed alongside the project documentation.

Screenshots of MySQL Workbench queries and outputs are stored in the repository's screenshot folder, where available.

If your screenshot folder is named `screenshots`, browse it here:

[View SQL screenshots](screenshots/)

## Metric Definitions and Limitations

- **Account churn:** The account-level churn flag is available, but its business
