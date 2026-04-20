-- ============================================
-- 05_return_analysis.sql
-- ============================================
-- Objective:
-- Analyze product returns and evaluate return rate reliability
-- ============================================


-- ============================================
-- QUESTION 1:
-- What is the return rate for each product?
-- ============================================

SELECT
    stock_code,
    description,

    -- quantity sold
    SUM(CASE WHEN quantity > 0 THEN quantity ELSE 0 END) AS quantity_sold,

    -- quantity returned
    SUM(CASE WHEN quantity < 0 THEN ABS(quantity) ELSE 0 END) AS quantity_returned,

    -- return rate %
    ROUND(
        1.0 * SUM(ABS(CASE WHEN quantity < 0 THEN quantity END))
        /
        NULLIF(SUM(CASE WHEN quantity > 0 THEN quantity END), 0),
    2) * 100 AS return_rate_percentage,

    -- number of orders with returns
    COUNT(DISTINCT CASE WHEN quantity < 0 THEN invoice_no END) AS orders_with_returns

FROM online_retail_clean
GROUP BY stock_code, description
ORDER BY return_rate_percentage DESC NULLS LAST;



-- ============================================
-- QUESTION 2:
-- Which products have the highest return rates?
-- ============================================

SELECT *
FROM (
    SELECT
        stock_code,
        description,

        SUM(CASE WHEN quantity > 0 THEN quantity ELSE 0 END) AS quantity_sold,
        SUM(CASE WHEN quantity < 0 THEN ABS(quantity) ELSE 0 END) AS quantity_returned,

        ROUND(
            1.0 * SUM(ABS(CASE WHEN quantity < 0 THEN quantity END))
            /
            NULLIF(SUM(CASE WHEN quantity > 0 THEN quantity END), 0),
        2) * 100 AS return_rate_percentage

    FROM online_retail_clean
    GROUP BY stock_code, description
) t
WHERE return_rate_percentage IS NOT NULL
ORDER BY return_rate_percentage DESC;



-- ============================================
-- QUESTION 3:
-- Are there anomalies in the return rate metric?
-- ============================================

SELECT *
FROM (
    SELECT
        stock_code,
        description,

        SUM(CASE WHEN quantity > 0 THEN quantity ELSE 0 END) AS quantity_sold,
        SUM(CASE WHEN quantity < 0 THEN ABS(quantity) ELSE 0 END) AS quantity_returned,

        ROUND(
            1.0 * SUM(ABS(CASE WHEN quantity < 0 THEN quantity END))
            /
            NULLIF(SUM(CASE WHEN quantity > 0 THEN quantity END), 0),
        2) * 100 AS return_rate_percentage

    FROM online_retail_clean
    GROUP BY stock_code, description
) t
WHERE return_rate_percentage > 100
ORDER BY return_rate_percentage DESC;