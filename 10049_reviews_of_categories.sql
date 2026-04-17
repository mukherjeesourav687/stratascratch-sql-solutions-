-- Problem: Reviews of Categories
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Split the comma-separated categories into individual rows
-- 2. Use a numbers table to extract each category using substring_index
-- 3. Trim spaces to clean category names
-- 4. Aggregate total reviews for each category
-- 5. Sort results in descending order of total reviews

SELECT
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(b.categories, ',', n.n), ',', -1)) AS category,
    SUM(b.review_count) AS total_reviews
FROM yelp_business b
JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
    UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16
    UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20
) n
ON n.n <= 1 + LENGTH(b.categories) - LENGTH(REPLACE(b.categories, ',', ''))
GROUP BY category
ORDER BY total_reviews DESC;