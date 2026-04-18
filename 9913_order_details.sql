-- Problem: Order Details
-- Platform: StrataScratch
-- Difficulty: Easy

-- Approach:
-- 1. Join customers and orders tables using customer id
-- 2. Filter records where first_name is 'Jill' or 'Eva'
-- 3. Select required columns (first_name, order_date, order_details, total_order_cost)
-- 4. Sort results by customer id

SELECT
    c.first_name,
    o.order_date,
    o.order_details,
    o.total_order_cost
FROM customers c
JOIN orders o
ON c.id = o.cust_id
WHERE c.first_name IN ('Jill', 'Eva')
ORDER BY o.cust_id;