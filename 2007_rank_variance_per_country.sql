-- Problem: Rank Variance Per Country
-- Source: StrataScratch
-- ID: 2007
-- Difficulty: Hard

WITH country_comments AS (
    SELECT 
        u.country,
        DATE_FORMAT(c.created_at, '%Y-%m-01') AS month,
        SUM(c.number_of_comments) AS total_comments
    FROM fb_comments_count c
    JOIN fb_active_users u 
        ON c.user_id = u.user_id
    WHERE c.created_at BETWEEN '2019-12-01' AND '2020-01-31'
    GROUP BY u.country, DATE_FORMAT(c.created_at, '%Y-%m-01')
),

ranked AS (
    SELECT 
        country,
        month,
        total_comments,
        DENSE_RANK() OVER (
            PARTITION BY month 
            ORDER BY total_comments DESC
        ) AS rnk
    FROM country_comments
),

dec_jan AS (
    SELECT 
        country,
        MAX(CASE WHEN month = '2019-12-01' THEN rnk END) AS dec_rank,
        MAX(CASE WHEN month = '2020-01-01' THEN rnk END) AS jan_rank
    FROM ranked
    GROUP BY country
)

SELECT country
FROM dec_jan
WHERE jan_rank < dec_rank;

-- Explanation:
-- Step 1: Aggregate total comments per country per month
-- Step 2: Rank countries within each month using DENSE_RANK
-- Step 3: Extract December and January ranks per country
-- Step 4: Compare ranks to find improvement (lower rank number is better)