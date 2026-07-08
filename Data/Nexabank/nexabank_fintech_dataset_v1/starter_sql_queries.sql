-- NexaBank Starter SQL Queries

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL SELECT 'merchants', COUNT(*) FROM merchants
UNION ALL SELECT 'cards', COUNT(*) FROM cards
UNION ALL SELECT 'loans', COUNT(*) FROM loans
UNION ALL SELECT 'support_tickets', COUNT(*) FROM support_tickets
UNION ALL SELECT 'marketing_interactions', COUNT(*) FROM marketing_interactions
UNION ALL SELECT 'fraud_flags', COUNT(*) FROM fraud_flags
UNION ALL SELECT 'customer_monthly_snapshot', COUNT(*) FROM customer_monthly_snapshot;

SELECT email, COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT COUNT(*) AS transactions_without_valid_merchant
FROM transactions t
LEFT JOIN merchants m ON t.merchant_id = m.merchant_id
WHERE m.merchant_id IS NULL;

SELECT
    m.merchant_category,
    COUNT(t.transaction_id) AS total_transactions,
    COUNT(f.flag_id) AS fraud_flags,
    ROUND(100.0 * COUNT(f.flag_id) / COUNT(t.transaction_id), 2) AS fraud_flag_rate
FROM transactions t
LEFT JOIN merchants m ON t.merchant_id = m.merchant_id
LEFT JOIN fraud_flags f ON t.transaction_id = f.transaction_id
GROUP BY m.merchant_category
ORDER BY fraud_flag_rate DESC;

SELECT
    CASE WHEN support_tickets_count > 0 THEN 'Had Support Ticket' ELSE 'No Support Ticket' END AS support_group,
    COUNT(*) AS customer_months,
    ROUND(100.0 * AVG(CASE WHEN churn_flag THEN 1 ELSE 0 END), 2) AS churn_rate
FROM customer_monthly_snapshot
GROUP BY 1;
