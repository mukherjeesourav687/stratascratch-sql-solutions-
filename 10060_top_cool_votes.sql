-- Problem: Top Cool Votes
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Find the maximum number of cool votes from all reviews
-- 2. Filter the records where cool votes equal the maximum value
-- 3. Select business name and review text

SELECT
    business_name,
    review_text
FROM yelp_reviews
WHERE cool = (
    SELECT MAX(cool)
    FROM yelp_reviews
);