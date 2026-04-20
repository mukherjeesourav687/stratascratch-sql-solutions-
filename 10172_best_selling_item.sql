-- Problem: Best Selling Item
-- Platform: StrataScratch
-- Difficulty: Hard

-- Approach:
-- 1. Calculate total sales per item per month (unitprice * quantity)
-- 2. Exclude cancelled/returned orders (invoice starting with 'C')
-- 3. Use a CTE to aggregate monthly sales
-- 4. For each month, find the item with the maximum total sales
-- 5. Return month, description, and total_paid

WITH monthly_sales AS (
    SELECT
        MONTH(invoicedate) AS month,
        description,
        SUM(unitprice * quantity) AS total_paid
    FROM online_retail
    WHERE invoice NOT LIKE 'C%'
    GROUP BY MONTH(invoicedate), description
)

SELECT
    month,
    description,
    total_paid
FROM monthly_sales
WHERE (month, total_paid) IN (
    SELECT
        month,
        MAX(total_paid)
    FROM monthly_sales
    GROUP BY month
)
ORDER BY month;