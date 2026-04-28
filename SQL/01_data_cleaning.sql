-- ============================================
-- 01_data_cleaning.sql
-- ============================================
-- Objective:
-- Clean raw transactional data and create
-- the analysis-ready table: online_retail_clean
-- ============================================

DROP TABLE IF EXISTS online_retail_clean;

CREATE TABLE online_retail_clean AS
SELECT
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_date,
    unit_price,
    customer_id,
    TRIM(country) AS country
FROM online_retail
WHERE customer_id IS NOT NULL
  AND quantity <> 0
  AND unit_price > 0;
