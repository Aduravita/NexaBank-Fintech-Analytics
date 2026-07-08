-- =====================================================
-- 03 Data Cleaning
-- Project: NexaBank Fintech Analytics
-- Purpose: Create cleaned loan table with correct data types
-- =====================================================

DROP TABLE IF EXISTS loans_clean;

CREATE TABLE loans_clean AS
SELECT
    loan_id,
    customer_id,
    start_date::date AS start_date,
    loan_amount::numeric AS loan_amount,
    interest_rate::numeric AS interest_rate,
    loan_type,
    loan_status,
    default_flag
FROM loans;

-- Validate cleaned table
SELECT
    COUNT(*) AS total_rows,
    MIN(loan_amount) AS min_loan,
    MAX(loan_amount) AS max_loan,
    ROUND(AVG(loan_amount), 2) AS avg_loan,
    MIN(interest_rate) AS min_rate,
    MAX(interest_rate) AS max_rate,
    ROUND(AVG(interest_rate), 2) AS avg_rate
FROM loans_clean;

-- Validate loan status distribution
SELECT
    loan_status,
    COUNT(*) AS loans
FROM loans_clean
GROUP BY loan_status
ORDER BY loans DESC;