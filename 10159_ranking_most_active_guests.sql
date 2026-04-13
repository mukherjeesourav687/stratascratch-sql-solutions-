-- Problem: Ranking Most Active Guests
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Aggregate total messages per guest
-- 2. Rank guests based on total messages using DENSE_RANK()
-- 3. Order results by ranking and guest ID

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(n_messages) DESC) AS ranking,
    id_guest,
    SUM(n_messages) AS total_messages
FROM airbnb_contacts
GROUP BY id_guest
ORDER BY ranking, id_guest;