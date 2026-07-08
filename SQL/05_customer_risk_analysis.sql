-- =====================================================
-- 05 Customer Risk Analysis
-- Project: NexaBank Fintech Analytics
-- Purpose: Analyze default risk by customer attributes
-- =====================================================

-- Default rate by age group
SELECT
    CASE
        WHEN c.age < 25 THEN 'Under 25'
        WHEN c.age < 35 THEN '25-34'
        WHEN c.age < 45 THEN '35-44'
        WHEN c.age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        100.0 * SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loans_clean l
JOIN customers c
    ON l.customer_id = c.customer_id
GROUP BY age_group
ORDER BY default_rate DESC;

-- Default rate by income band
SELECT
    CASE
        WHEN c.annual_income < 30000 THEN 'Under €30k'
        WHEN c.annual_income < 60000 THEN '€30k–60k'
        WHEN c.annual_income < 100000 THEN '€60k–100k'
        ELSE 'Over €100k'
    END AS income_band,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        100.0 * SUM(CASE WHEN l.loan_status = 'Defaulted' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM loans_clean l
JOIN customers c
    ON l.customer_id = c.customer_id
GROUP BY income_band
ORDER BY MIN(c.annual_income);

-- Customers with multiple loans
SELECT
    customer_id,
    COUNT(*) AS total_loans,
    ROUND(SUM(loan_amount), 2) AS total_borrowed
FROM loans_clean
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_loans DESC, total_borrowed DESC
LIMIT 10;

-- Top 10 largest loans
SELECT
    loan_id,
    customer_id,
    loan_type,
    loan_status,
    loan_amount,
    interest_rate
FROM loans_clean
ORDER BY loan_amount DESC
LIMIT 10;