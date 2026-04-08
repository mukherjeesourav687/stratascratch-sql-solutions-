-- Problem: 10322. Finding User Purchases
-- Platform: StrataScratch
-- Difficulty: Medium

WITH first_purchase AS (
    SELECT 
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM amazon_transactions
    GROUP BY user_id
)

SELECT DISTINCT t.user_id
FROM amazon_transactions t
JOIN first_purchase f
    ON t.user_id = f.user_id
WHERE t.created_at > f.first_purchase_date
  AND DATEDIFF(t.created_at, f.first_purchase_date) BETWEEN 1 AND 7;

-- Explanation:
-- Step 1: Find each user's first purchase date using MIN(created_at)
-- Step 2: Join back with the original table to compare all transactions
-- Step 3: Filter transactions that happened AFTER the first purchase
-- Step 4: Use DATEDIFF to ensure the second purchase is within 1–7 days
-- Step 5: DISTINCT ensures each user_id appears only once