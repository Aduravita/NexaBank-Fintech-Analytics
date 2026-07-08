# NexaBank Fintech Dataset - Data Dictionary

Synthetic fintech dataset for a data analyst portfolio project.

## Tables
- customers: customer profile, KYC, segment, income, country. Includes missing income, duplicate profiles, inconsistent country naming.
- accounts: account ownership, type, currency, status, balance, overdraft.
- transactions: card payments, transfers, ATM, refunds, fees. Includes failed payments, chargebacks, mixed currencies, outliers, and broken merchant references.
- merchants: merchant category, country, and risk level.
- cards: debit, credit, and virtual card records.
- loans: loan products and default flags.
- support_tickets: customer service activity and satisfaction.
- marketing_interactions: campaign exposure, clicks, conversions.
- fraud_flags: fraud/risk investigations linked to transactions.
- customer_monthly_snapshot: monthly activity table for churn and retention.

## Main relationships
customers.customer_id -> accounts.customer_id
accounts.account_id -> transactions.account_id
merchants.merchant_id -> transactions.merchant_id
transactions.transaction_id -> fraud_flags.transaction_id
customers.customer_id -> loans.customer_id
customers.customer_id -> support_tickets.customer_id
customers.customer_id -> marketing_interactions.customer_id
customers.customer_id -> customer_monthly_snapshot.customer_id
