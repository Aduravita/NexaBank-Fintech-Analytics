-- =====================================================
-- 06 Transaction Analysis
-- Project: NexaBank Fintech Analytics
-- Purpose: Analyze transaction behavior and operational activity
-- =====================================================

-- Transaction activity by loan status
SELECT
    l.loan_status,
    COUNT(DISTINCT t.customer_id) AS customers,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(AVG(t.amount), 2) AS average_transaction_amount,
    ROUND(SUM(t.amount), 2) AS total_transaction_volume
FROM loans_clean l
JOIN transactions t
    ON l.customer_id = t.customer_id
GROUP BY l.loan_status
ORDER BY total_transaction_volume DESC;

-- Average transaction activity per customer
SELECT
    l.loan_status,
    COUNT(DISTINCT t.customer_id) AS customers,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(
        COUNT(t.transaction_id) * 1.0 / COUNT(DISTINCT t.customer_id),
        2
    ) AS transactions_per_customer,
    ROUND(AVG(t.amount), 2) AS average_transaction_amount
FROM loans_clean l
JOIN transactions t
    ON l.customer_id = t.customer_id
GROUP BY l.loan_status
ORDER BY transactions_per_customer DESC;

-- Transactions by payment channel
SELECT
    payment_channel,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS transaction_volume
FROM transactions
GROUP BY payment_channel
ORDER BY total_transactions DESC;

-- Transaction status distribution
SELECT
    transaction_status,
    COUNT(*) AS total_transactions,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM transactions
GROUP BY transaction_status
ORDER BY total_transactions DESC;

-- Chargebacks and refunds
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_chargeback = TRUE THEN 1 ELSE 0 END) AS chargebacks,
    SUM(CASE WHEN is_refund = TRUE THEN 1 ELSE 0 END) AS refunds
FROM transactions;