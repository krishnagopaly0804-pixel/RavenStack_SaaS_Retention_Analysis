# RavenStack SaaS Retention Analysis

## Project Overview

This project analyzes SaaS customer retention, subscription churn, churn reasons, feature usage, support-ticket patterns, and cohort activity using SQL and MySQL.

The goal is to identify retention risks, validate churn metrics, and recommend practical actions to improve customer retention.

## Business Objectives

- Define and distinguish account churn, subscription churn, and churn events.
- Analyze monthly churn-event trends and recorded cancellation reasons.
- Evaluate month-end active retention by subscription-start cohort.
- Explore relationships between support-ticket patterns, feature usage, and churn status.
- Identify data-quality issues that may affect business reporting.
- Recommend evidence-based customer-retention actions.

## Tools and Technologies

- **MySQL** — querying and analyzing relational data
- **MySQL Workbench** — running SQL queries and validating results
- **GitHub** — version control and project documentation
- **SQL** — common table expressions, date functions, aggregations, joins, and data-quality checks

## Dataset Overview

The project uses five source tables:

| Table | Description |
|---|---|
| `raw_accounts` | Account information, signup dates, plan tiers, and account churn flags |
| `raw_subscriptions` | Subscription dates, revenue fields, plan changes, and subscription churn flags |
| `raw_churn_events` | Recorded churn reasons, churn dates, and reactivation events |
| `raw_feature_usage` | Feature usage counts, duration, and errors |
| `raw_support_tickets` | Support priorities, response and resolution times, satisfaction, and escalations |

Source data is retained in raw tables for analysis and validation.

## Analysis Areas

1. Raw-data schema inspection and data-quality checks
2. Subscription churn and account-status validation
3. Monthly active-account analysis
4. Monthly churn-event trends
5. Churn-reason analysis, including December 2024
6. Support-ticket and feature-usage comparisons
7. Cohort retention based on first subscription start month
8. Business insights and retention recommendations

## Preliminary Findings

- The account table contains 500 accounts, including 110 with `churn_flag = true`.
- The subscription table contains 486 subscriptions marked as churned.
- There are 600 churn events, including reactivation events.
- Among 539 non-reactivation churn events, features, support, and budget are the three most frequently recorded reason categories.
- December 2024 recorded 106 non-reactivation churn events; budget was the most frequently recorded reason that month.
- Cohort results show high month-end active retention, but the figures require careful interpretation because accounts can have multiple subscriptions and may reactivate.

These are descriptive findings from the supplied dataset, not proof of causal relationships.

## Metric Definitions and Limitations

- **Account churn:** Based on the account-level churn flag; its business meaning should be documented and reconciled with subscription activity.
- **Subscription churn:** Based on subscription-level status and end-date information.
- **Churn events:** Recorded cancellation-related events; event counts can exceed unique-account counts.
- **Month-end active retention:** Percentage of cohort accounts with at least one subscription active at a reporting month-end.

Month-end activity does not prove continuous activity throughout a month. Churn rates and retention claims should be finalized only after validating metric definitions, reactivation handling, and conflicting status fields.

## Repository Structure

```text
.
├── README.md
├── docs/
│   ├── data_dictionary.md
│   └── business_insights.md
└── sql/
    ├── 01_create_database.sql
    ├── 02_inspect_raw_schemas.sql
    ├── 03_data_quality_checks.sql
    ├── 04_subscription_churn_analysis.sql
    ├── 05_monthly_active_accounts.sql
    ├── 06_monthly_churn_events.sql
    ├── 07_churn_reason_analysis.sql
    ├── 08_support_churn_comparison.sql
    ├── 09_feature_usage_churn_analysis.sql
    ├── 10_retention_validation.sql
    ├── 11_december_churn_reason_analysis.sql
    └── 12_cohort_retention_analysis.sql
```

## Recommended Next Steps

- Reconcile account, subscription, and churn-event definitions.
- Validate cohort retention and reactivation behavior.
- Add a visual dashboard for churn trends and cohort analysis.
- Track retention KPIs with clearly documented denominators.

## Project Status

SQL analysis and preliminary business-insight documentation are in progress. Findings will be refined as metric validation continues.
