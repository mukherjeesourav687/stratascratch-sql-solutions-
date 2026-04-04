-- Problem: Users By Average Session Time
-- Source: StrataScratch
-- ID: 10352
-- Difficulty: Medium

SELECT 
    user_id,
    AVG(session_time) AS avg_session_time
FROM (
    SELECT 
        user_id,
        DATE(timestamp) AS session_date,
        MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS exit_time,
        MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS load_time,
        TIMESTAMPDIFF(
            SECOND,
            MAX(CASE WHEN action = 'page_load' THEN timestamp END),
            MIN(CASE WHEN action = 'page_exit' THEN timestamp END)
        ) AS session_time
    FROM facebook_web_log
    GROUP BY user_id, DATE(timestamp)
) t
WHERE load_time < exit_time
GROUP BY user_id;

-- Explanation:
-- We group data per user per day to define a session
-- MAX(page_load) ensures we take the latest load event
-- MIN(page_exit) ensures we take the earliest exit event
-- TIMESTAMPDIFF calculates session duration in seconds
-- We filter only valid sessions where load happens before exit
-- Finally, we take AVG(session_time) per user