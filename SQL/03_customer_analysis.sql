-- ============================================
-- 03_customer_analysis.sql
-- ============================================
-- Objective:
-- Analyze customer behavior and contribution to revenue
-- ============================================


-- ============================================
-- QUESTION 1:
-- Who are the top customers by total spending?
-- ============================================

SELECT
    customer_id,
    SUM(quantity * unit_price) AS total_spent
FROM online_retail_clean
GROUP BY customer_id
ORDER BY total_spent DESC;



-- ============================================
-- QUESTION 2:
-- How is revenue distributed across customers?
-- ============================================

SELECT
    customer_id,
    SUM(quantity * unit_price) AS revenue
FROM online_retail_clean
GROUP BY customer_id
ORDER BY revenue DESC;



-- ============================================
-- QUESTION 3:
-- How many orders does each customer place?
-- ============================================

SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS number_of_orders
FROM online_retail_clean
GROUP BY customer_id
ORDER BY number_of_orders DESC;