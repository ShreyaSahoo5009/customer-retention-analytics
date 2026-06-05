CREATE DATABASE customer_analysis;
USE customer_analysis;
SELECT * FROM customer_360;

-- ============================
-- ANALYSIS QUERIES
-- ============================

-- ============================
-- QUERY 1 — CUSTOMER SEGMENT DISTRIBUTION
-- ============================
SELECT
    customer_segment,
    COUNT(*) AS total_customers
FROM customer_360
GROUP BY customer_segment;

-- ============================
-- QUERY 2 — REVENUE BY SEGMENT
-- ============================
SELECT
    customer_segment,
    ROUND(SUM(total_spend),2) AS revenue
FROM customer_360
GROUP BY customer_segment
ORDER BY revenue DESC;

-- ============================
-- QUERY 3 — PROMO DEPENDENCY
-- ============================
SELECT
    customer_segment,
    ROUND(AVG(promo_ratio),2) AS avg_promo_dependency
FROM customer_360
GROUP BY customer_segment;

-- ============================
-- QUERY 4 — IDEAL CUSTOMER PROFILE
-- ============================
SELECT
    ROUND(AVG(total_spend),2) AS avg_spend,
    ROUND(AVG(avg_order_value),2) AS avg_order_value,
    ROUND(AVG(loyalty_score),2) AS avg_loyalty
FROM customer_360
WHERE customer_segment = 'High Value Organic';

-- =====================================
-- QUERY 5 — SUBSCRIPTION IMPACT
-- =====================================
SELECT
    subscription_status,
    ROUND(AVG(total_spend),2) AS avg_spend,
    ROUND(AVG(loyalty_score),2) AS avg_loyalty
FROM customer_360
GROUP BY subscription_status;

-- =====================================
-- QUERY 6 – SHIPPING TYPE ANALYSIS
-- =====================================

SELECT
    shipping_type,
    ROUND(AVG(avg_order_value),2) AS avg_spend
FROM customer_360
GROUP BY shipping_type
ORDER BY avg_spend DESC;

-- =====================================
-- QUERY 7 – REVENUE BY SEASON
-- =====================================

SELECT
    season,
    ROUND(SUM(total_spend),2) AS total_revenue
FROM customer_360
GROUP BY season
ORDER BY total_revenue DESC;

-- =====================================
-- QUERY 8 : CUSTOMER SATISFACTION ANALYSIS
-- =====================================

SELECT
	satisfaction_flag,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_spend),2) AS avg_spend,
    ROUND(AVG(loyalty_score),2) AS avg_loyalty
FROM customer_360
GROUP BY satisfaction_flag;

-- =====================================
-- QUERY 9 : SATISFACTION BY CUSTOMER SEGMENT
-- =====================================

SELECT
    customer_segment,
	satisfaction_flag,
	COUNT(*) AS total_customers,
    ROUND(AVG(total_spend),2) AS avg_spend
FROM customer_360
GROUP BY customer_segment, satisfaction_flag
ORDER BY avg_spend DESC;
