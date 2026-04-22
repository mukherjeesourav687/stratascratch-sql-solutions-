-- Problem: Counting Instances in Text
-- Platform: StrataScratch
-- Difficulty: Hard

-- Approach:
-- 1. Convert text to lowercase for case-insensitive matching
-- 2. Use REGEXP_REPLACE to remove exact word matches (bull / bear)
-- 3. Subtract lengths before & after replacement
-- 4. Divide by word length to get count of occurrences
-- 5. Repeat for both words and combine using UNION ALL
-- 6. Aggregate final counts

SELECT
    word,
    SUM(occurrences) AS occurrences
FROM (
    SELECT 
        'bull' AS word,
        ROUND(
            (LENGTH(LOWER(contents)) - LENGTH(REGEXP_REPLACE(LOWER(contents), '\\bbull\\b', '')))
            / LENGTH('bull')
        ) AS occurrences
    FROM google_file_store

    UNION ALL

    SELECT 
        'bear',
        ROUND(
            (LENGTH(LOWER(contents)) - LENGTH(REGEXP_REPLACE(LOWER(contents), '\\bbear\\b', '')))
            / LENGTH('bear')
        )
    FROM google_file_store
) t
GROUP BY word;