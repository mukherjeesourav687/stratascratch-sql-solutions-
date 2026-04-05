-- Problem: Acceptance Rate By Date
-- Source: StrataScratch
-- ID: 10285
-- Difficulty: Medium

SELECT 
    s.date,
    ROUND(
        COUNT(a.user_id_sender) * 1.0 / COUNT(s.user_id_sender),
        2
    ) AS acceptance_rate
FROM fb_friend_requests s
LEFT JOIN fb_friend_requests a
    ON s.user_id_sender = a.user_id_sender
    AND s.user_id_receiver = a.user_id_receiver
    AND a.action = 'accepted'
WHERE s.action = 'sent'
GROUP BY s.date
HAVING COUNT(a.user_id_sender) > 0;

-- Explanation:
-- We consider only rows where requests are sent
-- LEFT JOIN is used to match accepted requests with sent ones
-- COUNT(a.user_id_sender) gives number of accepted requests
-- COUNT(s.user_id_sender) gives total requests sent
-- Division gives acceptance rate per date
-- HAVING ensures at least one accepted request exists for that date