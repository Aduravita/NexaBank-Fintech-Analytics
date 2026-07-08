-- =====================================================
-- 08 Dashboard Support Queries
-- Project: NexaBank Fintech Analytics
-- Purpose: Validate Power BI KPIs and dashboard metrics
-- =====================================================

-- Executive KPI validation
SELECT
    COUNT(*) AS total_loans,
    ROUND(SUM(loan_amount), 2) AS total_portfolio_value,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 'Defaulted' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loans_clean;

-- Total transactions and volume
SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS transaction_volume,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM transactions;

-- Fraud KPI validation
SELECT
    COUNT(*) AS fraud_flags,
    ROUND(AVG(risk_score)::numeric, 2) AS average_risk_score
FROM fraud_flags;

-- Customer count by segment
SELECT
    customer_segment,
    COUNT(*) AS customers
FROM customers
GROUP BY customer_segment
ORDER BY customers DESC;

-- Loan status by customer segment
SELECT
    c.customer_segment,
    l.loan_status,
    COUNT(*) AS loans
FROM loans_clean l
JOIN customers c
    ON l.customer_id = c.customer_id
GROUP BY c.customer_segment, l.loan_status
ORDER BY c.customer_segment, loans DESC;