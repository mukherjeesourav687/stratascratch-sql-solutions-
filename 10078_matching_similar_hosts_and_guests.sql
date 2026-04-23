-- Problem: Matching Similar Hosts and Guests
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Join hosts and guests tables
-- 2. Match on gender and nationality
-- 3. Select required host_id and guest_id
-- 4. Use DISTINCT to avoid duplicate pairs

SELECT DISTINCT
    h.host_id,
    g.guest_id
FROM airbnb_hosts h
JOIN airbnb_guests g
ON h.gender = g.gender
AND h.nationality = g.nationality;