-- ============================================
-- 02_sales_analysis.sql
-- ============================================
-- Objective:
-- Analyze sales performance and revenue trends
-- ============================================


-- ============================================
-- QUESTION 1:
-- How does revenue evolve over time?
-- ============================================

SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    SUM(quantity * unit_price) AS revenue
FROM online_retail_clean
GROUP BY month
ORDER BY month;



-- ============================================
-- QUESTION 2:
-- Which countries generate the highest revenue?
-- ============================================

SELECT
    country,
    SUM(quantity * unit_price) AS revenue
FROM online_retail_clean
GROUP BY country
ORDER BY revenue DESC;



-- ============================================
-- QUESTION 3:
-- What is the distribution of order values?
-- ============================================

SELECT
    invoice_no,
    SUM(quantity * unit_price) AS order_value
FROM online_retail_clean
GROUP BY invoice_no
ORDER BY order_value DESC;