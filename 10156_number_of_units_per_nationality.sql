-- Problem: Number Of Units Per Nationality
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Join hosts and units tables
-- 2. Filter hosts under age 30
-- 3. Consider only 'Apartment' unit type
-- 4. Count distinct unit_id per nationality
-- 5. Sort by count in descending order

SELECT
    h.nationality,
    COUNT(DISTINCT u.unit_id) AS apartment_count
FROM airbnb_hosts h
JOIN airbnb_units u
    ON h.host_id = u.host_id
WHERE h.age < 30
  AND u.unit_type = 'Apartment'
GROUP BY h.nationality
ORDER BY apartment_count DESC;