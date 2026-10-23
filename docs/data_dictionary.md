# Data Dictionary — RavenStack SaaS Retention Analysis

## 1. Purpose

This document describes the tables, columns, and business meaning of the dataset used for the RavenStack SaaS Customer Retention Analysis project.

The data dictionary helps maintain consistent definitions during data cleaning, SQL analysis, and reporting.

## 2. Dataset Overview

The project uses five source tables:

| Table Name | Description | Initial Records |
|---|---|---:|
| `raw_accounts` | Account-level information and churn indicators | 500 |
| `raw_subscriptions` | Subscription records, dates, and status indicators | 5,000 |
| `raw_churn_events` | Churn and reactivation event records | 600 |
| `raw_feature_usage` | Customer subscription feature usage activity | 25,000 |
| `raw_support_tickets` | Customer support interaction records | 2,000 |
| **Total** | **All source tables** | **33,100** |

Record counts describe the initial imported dataset and should be revalidated if the data changes.

## 3. Table Descriptions

### 3.1 `raw_accounts`

Contains account-level information used to understand the customer base and account churn indicators.

| Column | Business Meaning |
|---|---|
| `account_id` | Unique identifier for an account |
| `churn_flag` | Account-level indicator of churn, according to the source dataset |
| Other source columns | Record their exact names and meanings after inspecting the table schema |

### 3.2 `raw_subscriptions`

Contains subscription-level records and subscription lifecycle information.

| Column | Business Meaning |
|---|---|
| `subscription_id` | Unique identifier for a subscription |
| `account_id` | Identifier linking a subscription to an account |
| `start_date` | Subscription start date |
| `end_date` | Subscription end date, when available |
| `churn_flag` | Source-provided subscription churn indicator |
| Other source columns | Record their exact names and meanings after inspecting the table schema |

### 3.3 `raw_churn_events`

Records churn-related events, including reactivation events where present.

| Column | Business Meaning |
|---|---|
| Event identifier | Identifier for an event, if provided |
| Subscription/account identifier | Entity associated with the event |
| Event date | Date on which the event occurred |
| Event type or reason | Classification of the event, if provided |

Exact column names should be confirmed from the imported table schema.

### 3.4 `raw_feature_usage`

Contains feature usage activity associated with customer subscriptions.

| Column | Business Meaning |
|---|---|
| Subscription/account identifier | Entity associated with the usage record |
| Usage date | Date of recorded activity |
| Feature information | Feature associated with the activity |
| Usage metrics | Measures of feature usage, according to the source columns |

Exact column names and metric definitions should be confirmed from the table schema.

### 3.5 `raw_support_tickets`

Contains customer support interaction records.

| Column | Business Meaning |
|---|---|
| Ticket identifier | Unique ticket identifier, if provided |
| Subscription/account identifier | Customer entity associated with the ticket |
| Ticket date | Date of the support interaction |
| Status, category, or priority | Support ticket attributes, if provided |

Exact column names should be confirmed from the imported table schema.

## 4. Important Business Definitions

- **Account:** A customer organization or account represented in the account table.
- **Subscription:** A subscription record associated with an account.
- **Churn event:** A recorded churn-related event; reactivation events should be distinguished from churn events.
- **Active subscription:** A subscription considered active under an explicitly defined reporting date and lifecycle rule.
- **Retention:** The proportion of a defined customer cohort that remains active over a specified period.
- **Churn rate:** The proportion of customers or subscriptions that churn during a defined period, using a clearly stated denominator.

## 5. Data Quality and Interpretation Notes

- The dataset is synthetic and is used for analytical practice.
- Account-level churn flags and subscription-level churn indicators represent different levels of analysis.
- A missing subscription end date must not automatically be treated as proof of retention without validating the source data and business rules.
- Churn events are event counts, not churn rates.
- Reactivation events should be analyzed separately from new churn events.
- Before calculating final metrics, validate date fields, relationships between tables, duplicate records, missing values, and conflicting churn indicators.
- Do not assume column names or data types; confirm them against the actual MySQL table definitions.

## 6. Planned Analytical Use

The tables will support analysis of:

1. Customer and subscription data quality.
2. Monthly active accounts and subscriptions.
3. Customer retention and churn patterns.
4. Churn reasons and reactivation events.
5. Feature usage and support interactions as potential churn indicators.
6. Business recommendations supported by validated findings.

## 7. Maintenance

Update this document whenever source schemas, column definitions, or business rules change. All final metrics should use documented and validated definitions.
