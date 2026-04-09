-- Problem: 10183. Total Cost Of Orders
-- Platform: StrataScratch
-- Difficulty: Easy

SELECT 
    c.id,
    c.first_name,
    SUM(o.total_order_cost) AS total_cost
FROM customers c
JOIN orders o
    ON c.id = o.cust_id
GROUP BY c.id, c.first_name
ORDER BY c.first_name;

-- Explanation:
-- Step 1: Join customers with orders using customer ID
-- Step 2: Use SUM() to calculate total order cost per customer
-- Step 3: GROUP BY ensures aggregation per customer
-- Step 4: Include first_name in GROUP BY to avoid SQL errors
-- Step 5: ORDER BY first_name to match the required output format