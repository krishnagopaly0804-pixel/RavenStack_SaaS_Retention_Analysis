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

## Metric Definitions and Limitations

- **Account churn:** The account-level churn flag is available, but its business meaning must be reconciled with subscription history and churn events.
- **Subscription churn:** The subscription-level churn flag and end-date fields are internally consistent in the final quality audit.
- **Churn events:** Recorded cancellation-related events. Event counts may exceed the number of unique accounts.
- **Month-end active status:** Whether an account has at least one subscription satisfying the selected month-end activity rule.
- **Monthly subscription-ending count:** The number of subscriptions whose recorded end dates fall within a calendar month.
- **Exploratory monthly churn rate:** Requires validation of the eligible starting population, date-boundary conventions, and treatment of reactivations before being treated as a final business KPI.

Additional limitations:

- Raw source columns were imported as text and require appropriate date and numeric parsing.
- Account-level and subscription-level counts represent different units of analysis.
- A subscription ending does not necessarily mean the entire account relationship ended.
- Recorded churn reasons, support patterns, and feature usage do not independently prove why a customer churned.
- Newer cohorts have shorter observation periods than older cohorts.

## Business Recommendations

1. **Finalize the account-churn definition:** Agree on how to handle multiple subscriptions, reactivations, and churn events.
2. **Investigate December subscription endings:** Compare end dates with contract renewals and billing frequency.
3. **Investigate recorded product and support concerns:** Work with product and customer-success teams to review feature and support-related feedback.
4. **Improve event coverage:** Investigate ended subscriptions and churned accounts without a matching non-reactivation churn event.
5. **Publish validated retention KPIs:** Calculate account churn, revenue churn, and cohort retention only after definitions and denominators are confirmed.

## Repository Structure

```text
RavenStack_SaaS_Retention_Analysis/
├── README.md
├── docs/
│   ├── data_dictionary.md
│   ├── business_insights.md
│   └── churn_definition.md
├── screenshots/
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
    ├── 12_cohort_retention_analysis.sql
    ├── 13_monthly_subscription_churn_rate.sql
    ├── 14_cohort_churn_flag_analysis.sql
    ├── 15_churn_event_validation.sql
    ├── 16_monthly_ended_subscription_analysis.sql
    ├── 17_december_churn_spike_validation.sql
    ├── 18_december_daily_ending_analysis.sql
    └── 19_final_subscription_quality_audit.sql
```

*Note: The structure above is the intended project layout. Confirm that the filenames and screenshot folder match your actual GitHub repository.*

## Project Status

The project includes SQL-based exploratory analysis, data-quality validation, churn-event analysis, cohort investigation, and business-insight documentation.

Further validation of the account-churn definition and retention metrics is required before presenting them as confirmed business KPIs.
