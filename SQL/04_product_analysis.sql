-- ============================================
-- 04_product_analysis.sql
-- ============================================
-- Objective:
-- Analyze product performance in terms of sales and revenue
-- ============================================


-- ============================================
-- QUESTION 1:
-- Which products generate the highest revenue?
-- ============================================

SELECT
    stock_code,
    description,
    SUM(quantity * unit_price) AS revenue
FROM online_retail_clean
GROUP BY stock_code, description
ORDER BY revenue DESC;



-- ============================================
-- QUESTION 2:
-- Which products are sold in the highest quantities?
-- ============================================

SELECT
    stock_code,
    description,
    SUM(quantity) AS total_quantity_sold
FROM online_retail_clean
WHERE quantity > 0
GROUP BY stock_code, description
ORDER BY total_quantity_sold DESC;



-- ============================================
-- QUESTION 3:
-- Are there products with high sales but low revenue (or vice versa)?
-- ============================================

SELECT
    stock_code,
    description,
    SUM(quantity) AS total_quantity_sold,
    SUM(quantity * unit_price) AS revenue
FROM online_retail_clean
WHERE quantity > 0
GROUP BY stock_code, description
ORDER BY total_quantity_sold DESC;