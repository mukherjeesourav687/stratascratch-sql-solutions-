-- Problem: 10319. Monthly Percentage Difference
-- Platform: StrataScratch
-- Difficulty: Hard

SELECT 
    curr.ym,
    ROUND(
        CASE 
            WHEN prev.revenue IS NULL THEN NULL
            ELSE ((curr.revenue - prev.revenue) / prev.revenue) * 100
        END, 2
    ) AS pct_change
FROM (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') AS ym,
        SUM(value) AS revenue
    FROM sf_transactions
    GROUP BY ym
) curr
LEFT JOIN (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') AS ym,
        SUM(value) AS revenue
    FROM sf_transactions
    GROUP BY ym
) prev
ON prev.ym = DATE_FORMAT(
    DATE_SUB(CONCAT(curr.ym, '-01'), INTERVAL 1 MONTH),
    '%Y-%m'
)
ORDER BY curr.ym;

-- Explanation:
-- Step 1: Aggregate monthly revenue using DATE_FORMAT
-- Step 2: Create two datasets → current month (curr) and previous month (prev)
-- Step 3: Join current month with previous month using DATE_SUB
-- Step 4: Calculate percentage change:
--         (current - previous) / previous * 100
-- Step 5: Handle NULL for the first month (no previous data)
-- Step 6: ROUND to 2 decimal places