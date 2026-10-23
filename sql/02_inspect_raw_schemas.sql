-- Project: RavenStack SaaS Customer Retention Analysis
-- Purpose: Inspect the structure of all imported raw tables.
-- These commands inspect schemas; they do not modify data.

USE saas_retention;

-- 1. Inspect account columns and data types.
SHOW CREATE TABLE raw_accounts;

-- 2. Inspect subscription columns and data types.
SHOW CREATE TABLE raw_subscriptions;

-- 3. Inspect churn event columns and data types.
SHOW CREATE TABLE raw_churn_events;

-- 4. Inspect feature usage columns and data types.
SHOW CREATE TABLE raw_feature_usage;

-- 5. Inspect support ticket columns and data types.
SHOW CREATE TABLE raw_support_tickets;
