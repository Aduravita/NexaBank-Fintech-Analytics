SELECT
    CASE
        WHEN f.customer_id IS NULL THEN 'No Fraud Flag'
        ELSE 'Fraud Flag'
    END AS fraud_status,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        100.0 * SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS default_rate
FROM loans_clean l
LEFT JOIN fraud_flags f
    ON l.customer_id = f.customer_id
GROUP BY fraud_status
ORDER BY default_rate DESC;