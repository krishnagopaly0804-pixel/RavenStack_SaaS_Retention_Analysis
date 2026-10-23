# RavenStack SaaS Retention Analysis — Business Insights

## 1. Project Objective

Analyze customer and subscription churn, monthly churn trends, churn reasons, support-ticket patterns, feature usage, and cohort retention to identify opportunities to improve customer retention.

## 2. Churn Overview

- The account dataset contains 500 accounts.
- 110 accounts have `churn_flag = true`, while 390 have `churn_flag = false`.
- The account-level churn flag should be interpreted separately from subscription-level churn and churn-event records.
- The dataset contains 486 subscriptions marked as churned and 600 churn events, including reactivation events.

**Interpretation:** Account churn, subscription churn, and churn events measure different things. They should not be combined into a single churn metric without an explicitly documented definition.

## 3. Leading Recorded Churn Reasons

Among 539 non-reactivation churn events:

| Recorded reason | Events | Share |
|---|---:|---:|
| Features | 101 | 18.74% |
| Support | 98 | 18.18% |
| Budget | 92 | 17.07% |
| Unknown | 86 | 15.96% |
| Pricing | 82 | 15.21% |
| Competitor | 80 | 14.84% |

**Interpretation:** Feature gaps, support, and budget-related reasons are the three largest recorded categories. These are reported reasons, not independently verified causes of churn.

## 4. December 2024 Churn Reasons

December recorded 106 non-reactivation churn events.

- Budget: 24 events (22.64%)
- Features: 20 events (18.87%)
- Unknown: 20 events (18.87%)
- Support: 19 events (17.92%)
- Competitor: 14 events (13.21%)
- Pricing: 9 events (8.49%)

**Interpretation:** Budget was the most frequently recorded reason in December. The team should investigate whether affordability, plan fit, or billing expectations contributed to these cancellations. The available data alone does not establish causation.

## 5. Cohort Retention

The analysis groups accounts by the month of their first recorded subscription start and checks whether each account has at least one active subscription at each month-end.

- January 2024 cohort: 26 accounts; 25 active at January month-end (96.15%); 26 active from February through December.
- June 2024 cohort: 27 accounts; 26 active in September (96.30%); all 27 active in October through December.
- The other 2024 cohorts showed 100% month-end active retention in the reported results.

**Important limitation:** Month-end activity is a snapshot, not proof of continuous activity. Accounts may become inactive and later reactivate, and multiple subscriptions per account can affect account-level activity. The unusually high retention values should be validated before being used as a business performance claim.

## 6. Support-Ticket Findings

The available support-ticket summary shows broadly similar average resolution times and satisfaction scores across priority groups. These descriptive results do not establish whether support performance causes churn.

A stronger follow-up analysis should link tickets to each account's churn date and examine only tickets submitted before churn.

## 7. Data Quality and Metric Definitions

Before publishing final churn rates or retention claims:

1. Document separate definitions for account churn, subscription churn, and churn events.
2. Investigate accounts whose account-level churn flag conflicts with their subscription activity.
3. Validate reactivation handling and subscription date boundaries.
4. Distinguish event counts from unique-account counts.
5. Analyze support tickets and feature usage relative to churn dates where possible.

## 8. Recommended Business Actions

1. **Investigate feature gaps:** Review feature-related feedback and identify commonly requested capabilities.
2. **Review support experiences:** Analyze pre-churn tickets, response times, resolution times, and escalations.
3. **Explore affordability options:** Test suitable plan tiers or downgrade options without assuming price is the sole cause.
4. **Improve exit-reason capture:** Reduce the number of churn events recorded with an unknown reason.
5. **Monitor reactivation:** Report cancellations and reactivations separately to avoid misleading churn and retention metrics.
6. **Validate retention definitions:** Reconcile subscription activity with account status before presenting retention as a final KPI.

## 9. Conclusion

The data identifies actionable areas for further investigation, particularly feature needs, support experience, affordability, and churn-reason quality. Final business conclusions should follow reconciliation of the account, subscription, and churn-event definitions. Cohort retention should be reported as month-end active retention unless continuous activity is explicitly measured.
