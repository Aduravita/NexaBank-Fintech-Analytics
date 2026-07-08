SELECT
    COUNT(*) FILTER (WHERE loan_amount IS NULL) AS missing_loan_amount,
    COUNT(*) FILTER (WHERE interest_rate IS NULL) AS missing_interest_rate,
    COUNT(*) FILTER (WHERE start_date IS NULL) AS missing_start_date
FROM loans_clean;