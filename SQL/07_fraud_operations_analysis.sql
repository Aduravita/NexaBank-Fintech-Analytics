-- =====================================================
-- 07 Fraud Analytics
-- Project: NexaBank Fintech Analytics
-- Purpose: Analyze fraud flags and relationship with credit risk
-- =====================================================

-- Fraud investigation status
SELECT
    investigation_status,
    COUNT(*) AS fraud_flags,
    ROUND(AVG(risk_score)::numeric, 2) AS average_risk_score
FROM fraud_flags
GROUP BY investigation_status
ORDER BY fraud_flags DESC;

-- Most common fraud reasons
SELECT
    flag_reason,
    COUNT(*) AS fraud_flags,
    ROUND(AVG(risk_score)::numeric, 2) AS average_risk_score
FROM fraud_flags
GROUP BY flag_reason
ORDER BY fraud_flags DESC;

-- Are fraud-flagged customers more likely to default?
SELECT
    CASE
        WHEN f.customer_id IS NULL THEN 'No Fraud Flag'
        ELSE 'Fraud Flag'
    END AS fraud_status,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        100.0 * SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loans_clean l
LEFT JOIN fraud_flags f
    ON l.customer_id = f.customer_id
GROUP BY fraud_status
ORDER BY default_rate DESC;

-- Fraud flags by customer
SELECT
    customer_id,
    COUNT(*) AS fraud_flags,
    ROUND(AVG(risk_score)::numeric, 2) AS average_risk_score
FROM fraud_flags
GROUP BY customer_id
ORDER BY fraud_flags DESC, average_risk_score DESC
LIMIT 20;