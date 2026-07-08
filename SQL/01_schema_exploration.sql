-- =====================================================
-- 01 Schema Exploration
-- Project: NexaBank Fintech Analytics
-- Purpose: Inspect database tables, columns, and structure
-- =====================================================

-- List all tables in the schema
SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


-- Inspect customers table columns
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'customers'
ORDER BY ordinal_position;


-- Inspect loans table columns
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'loans'
ORDER BY ordinal_position;


-- Inspect transactions table columns
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'transactions'
ORDER BY ordinal_position;


-- Inspect fraud_flags table columns
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'fraud_flags'
ORDER BY ordinal_position;


-- Preview key tables
SELECT * FROM customers LIMIT 10;
SELECT * FROM loans LIMIT 10;
SELECT * FROM transactions LIMIT 10;
SELECT * FROM fraud_flags LIMIT 10;