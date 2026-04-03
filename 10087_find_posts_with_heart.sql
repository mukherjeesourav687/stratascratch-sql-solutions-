-- Problem: Find all posts which were reacted to with a heart
-- Source: StrataScratch (ID: 10087)
-- Difficulty: Easy

SELECT DISTINCT fp.*
FROM facebook_posts fp
JOIN facebook_reactions fr
    ON fp.post_id = fr.post_id
WHERE fr.reaction = 'heart';

-- Explanation:
-- Join posts with reactions using post_id
-- Filter only 'heart' reactions
-- DISTINCT ensures no duplicate posts are returned