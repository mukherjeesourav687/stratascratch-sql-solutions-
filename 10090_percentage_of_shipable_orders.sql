-- Problem: Find the percentage of shipable orders
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Join orders with customers using customer id
-- 2. Check if address is NOT NULL → shipable order
-- 3. Use CASE to convert condition into 1/0
-- 4. Calculate percentage using SUM / COUNT
-- 5. Multiply by 100 for final percentage

SELECT
    100.0 * SUM(CASE WHEN c.address IS NOT NULL THEN 1 ELSE 0 END) 
    / COUNT(*) AS percentage_shipable
FROM orders o
JOIN customers c
ON o.cust_id = c.id;