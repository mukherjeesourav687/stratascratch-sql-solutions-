-- Problem: Consecutive Days
-- Platform: StrataScratch
-- Difficulty: Hard

-- Approach:
-- 1. Get unique user_id and record_date
-- 2. Use LEAD() to check next 1st and 2nd dates
-- 3. Compare if they form consecutive days
-- 4. Filter users where 3 consecutive days exist
-- 5. Select distinct user_id

SELECT DISTINCT user_id
FROM (
    SELECT
        user_id,
        record_date,
        LEAD(record_date, 1) OVER (PARTITION BY user_id ORDER BY record_date) AS next_1,
        LEAD(record_date, 2) OVER (PARTITION BY user_id ORDER BY record_date) AS next_2
    FROM (
        SELECT DISTINCT user_id, record_date
        FROM sf_events
    ) AS unique_events
) AS activity
WHERE next_1 = DATE_ADD(record_date, INTERVAL 1 DAY)
  AND next_2 = DATE_ADD(record_date, INTERVAL 2 DAY);