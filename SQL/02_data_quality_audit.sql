-- =====================================================
-- 02 Data Quality Audit
-- Project: NexaBank Fintech Analytics
-- Purpose: Identify missing values, duplicates, and basic quality issues
-- =====================================================

-- Count rows in main tables
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'loans', COUNT(*) FROM loans
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'fraud_flags', COUNT(*) FROM fraud_flags
UNION ALL
SELECT 'support_tickets', COUNT(*) FROM support_tickets;


-- Check duplicate customer profiles
SELECT
    COUNT(*) AS duplicate_profiles
FROM customers
WHERE is_duplicate_profile = TRUE;


-- Check KYC status distribution
SELECT
    kyc_status,
    COUNT(*) AS customers
FROM customers
GROUP BY kyc_status
ORDER BY customers DESC;


-- Check loan status distribution in raw loans table
SELECT
    loan_status,
    COUNT(*) AS loans
FROM loans
GROUP BY loan_status
ORDER BY loans DESC;


-- Check loan amount and interest rate ranges
SELECT
    COUNT(*) AS total_rows,
    MIN(loan_amount::numeric) AS min_loan,
    MAX(loan_amount::numeric) AS max_loan,
    AVG(loan_amount::numeric) AS avg_loan,
    MIN(interest_rate::numeric) AS min_rate,
    MAX(interest_rate::numeric) AS max_rate,
    AVG(interest_rate::numeric) AS avg_rate
FROM loans;


-- Check transaction status distribution
SELECT
    transaction_status,
    COUNT(*) AS transactions
FROM transactions
GROUP BY transaction_status
ORDER BY transactions DESC;


-- Check payment channel distribution
SELECT
    payment_channel,
    COUNT(*) AS transactions
FROM transactions
GROUP BY payment_channel
ORDER BY transactions DESC;


-- Check fraud investigation status
SELECT
    investigation_status,
    COUNT(*) AS fraud_flags
FROM fraud_flags
GROUP BY investigation_status
ORDER BY fraud_flags DESC;