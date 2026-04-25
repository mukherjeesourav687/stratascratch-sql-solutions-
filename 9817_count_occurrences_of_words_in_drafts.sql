-- Problem: Count Occurrences Of Words In Drafts
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Clean text → convert to lowercase and remove punctuation
-- 2. Use recursive CTE to split words by space
-- 3. Extract each word iteratively
-- 4. Count occurrences of each word
-- 5. Ignore empty strings and order by frequency

WITH RECURSIVE ws AS (
    SELECT
        LOWER(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(contents,
            ',', ' '), '.', ' '), '!', ' '), '?', ' '), ';', ' ')
        ) AS c
    FROM google_file_store
),

sw AS (
    SELECT
        SUBSTRING_INDEX(c, ' ', 1) AS word,
        SUBSTRING(c, LOCATE(' ', c) + 1) AS rest
    FROM ws

    UNION ALL

    SELECT
        SUBSTRING_INDEX(rest, ' ', 1),
        SUBSTRING(rest, LOCATE(' ', rest) + 1)
    FROM sw
    WHERE TRIM(rest) != ''
)

SELECT
    TRIM(word) AS word,
    COUNT(*) AS occurrences
FROM sw
WHERE TRIM(word) != ''
GROUP BY TRIM(word)
ORDER BY occurrences DESC;