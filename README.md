# RavenStack SaaS Customer Retention Analysis

## Project Overview

This project analyzes customer retention, subscription activity, and churn patterns for RavenStack, a synthetic SaaS business.

The goal is to understand customer activity over time, identify patterns in churn and reactivation, and develop data-driven recommendations that may help improve customer retention.

The analysis uses SQL as the primary tool, with Python and Power BI planned for deeper analysis and visualization.

## Business Objectives

- Analyze monthly subscription and customer activity.
- Understand customer retention and churn patterns.
- Examine churn events and recorded churn reasons.
- Investigate customer feature usage and support-ticket patterns.
- Identify potential signals associated with customer churn.
- Present findings through clear visualizations and business recommendations.

## Dataset Overview

The project dataset contains five tables:

| Table | Description |
|---|---|
| `raw_accounts` | Account-level information and churn flags |
| `raw_subscriptions` | Subscription records, start dates, end dates, and churn flags |
| `raw_churn_events` | Recorded churn and reactivation events |
| `raw_feature_usage` | Customer feature-usage activity |
| `raw_support_tickets` | Customer support interactions |

The current dataset contains 33,100 records across the five tables, based on the initial import counts.

**Data note:** The dataset is synthetic. Account-level churn flags, subscription status, and date-based activity may not always agree. These differences will be investigated and documented before final retention metrics are reported.

## Tools and Technologies

- **MySQL Workbench:** SQL queries, data validation, joins, and retention analysis.
- **Python:** Planned data analysis using pandas and visualization libraries.
- **Visual Studio Code:** Project development and file organization.
- **Power BI:** Planned interactive dashboard.
- **GitHub:** Project documentation and version history.

## Project Workflow

### 1. Dataset Understanding and Validation
- Review the available tables and columns.
- Verify imported record counts.
- Check selected missing values, repeated identifiers, and table relationships.
- Investigate data-quality issues without modifying the raw data unnecessarily.

### 2. SQL Analysis
- Analyze subscription status and end dates.
- Examine churn-event patterns and recorded reasons.
- Calculate monthly active subscriptions and active accounts.
- Validate customer-status definitions across the available tables.

### 3. Retention and Churn Metrics
- Define the customer population and reporting periods.
- Calculate monthly retention and churn metrics using documented rules.
- Examine reactivation and changes in customer activity.
- Validate results before interpreting business performance.

### 4. Python Analysis
- Explore customer behavior and feature-usage patterns.
- Investigate relationships between support interactions and churn.
- Create visualizations where useful.

### 5. Dashboard and Reporting
- Develop KPI visuals and a dashboard.
- Summarize the key findings.
- Prepare practical, evidence-based recommendations.

## Key Business Questions

1. How does the number of active accounts change over time?
2. How many subscriptions end each month?
3. What churn reasons are recorded most frequently?
4. How do customer activity and reactivation patterns change over time?
5. Are feature usage or support-ticket patterns associated with churn?
6. What actions could the business investigate to improve retention?

## Repository Structure

The repository will be organized as the project progresses.

```text
ravenstack-saas-retention-analysis/
├── README.md
├── docs/
├── sql/
├── python/
├── reports/
│   ├── charts/
│   └── dashboard/
└── requirements.txt
```

Files and folders will be added as their corresponding project stages are completed.

## Current Progress

- [x] Dataset imported into MySQL Workbench.
- [x] Initial record-count and selected data-quality checks completed.
- [x] Subscription status and end-date patterns examined.
- [x] Initial monthly subscription and account activity analysis performed.
- [ ] Resolve account-level and subscription-level churn discrepancies.
- [ ] Finalize monthly retention and churn calculations.
- [ ] Complete Python analysis and visualizations.
- [ ] Build the dashboard.
- [ ] Publish final findings and recommendations.

## Expected Deliverables

- Documented SQL scripts.
- Data-quality findings.
- Monthly customer activity and retention metrics.
- Python analysis and visualizations.
- An interactive dashboard, if Power BI is used.
- Final business insights and recommendations.

## Important Note

Retention and churn metrics will be reported only after the underlying customer-status definitions, reporting periods, and data limitations have been validated. An ended subscription does not necessarily mean that an entire customer account has permanently churned.

## Author

Data Analytics Portfolio Project — RavenStack SaaS Customer Retention Analysis
