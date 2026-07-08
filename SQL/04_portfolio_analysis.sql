-- =====================================================
-- 04 Portfolio Overview
-- Project: NexaBank Fintech Analytics
-- Purpose: Analyze loan portfolio size, status, products, and risk
-- =====================================================

-- Portfolio composition by loan status
SELECT
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM loans_clean
GROUP BY loan_status
ORDER BY total_loans DESC;

-- Loan portfolio by loan type
SELECT
    loan_type,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM loans_clean
GROUP BY loan_type
ORDER BY total_loans DESC;

-- Default rate by loan type
SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Defaulted' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 'Defaulted' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loans_clean
GROUP BY loan_type
ORDER BY default_rate DESC;

-- Total loan value by status
SELECT
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(SUM(loan_amount), 2) AS total_loan_value,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount
FROM loans_clean
GROUP BY loan_status
ORDER BY total_loan_value DESC;

-- Default rate by loan size
SELECT
    CASE
        WHEN loan_amount < 5000 THEN 'Under €5k'
        WHEN loan_amount < 10000 THEN '€5k–10k'
        WHEN loan_amount < 20000 THEN '€10k–20k'
        ELSE 'Over €20k'
    END AS loan_size,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Defaulted' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 'Defaulted' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loans_clean
GROUP BY loan_size
ORDER BY MIN(loan_amount);