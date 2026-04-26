-- Problem: Find the number of inspections for each risk category by inspection type
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Clean null/empty risk_category → replace with 'No Risk'
-- 2. Count inspections per inspection_type + risk_category
-- 3. Calculate total inspections per inspection_type
-- 4. Pivot risk categories using CASE
-- 5. Order by total inspections (descending)

WITH cleaned AS (
    SELECT 
        inspection_type,
        COALESCE(NULLIF(risk_category, ''), 'No Risk') AS risk_category
    FROM sf_restaurant_health_violations
),
counted AS (
    SELECT 
        inspection_type,
        risk_category,
        COUNT(*) AS inspection_count
    FROM cleaned
    GROUP BY inspection_type, risk_category
),
totals AS (
    SELECT 
        inspection_type,
        SUM(inspection_count) AS total_inspections
    FROM counted
    GROUP BY inspection_type
)

SELECT 
    c.inspection_type,
    SUM(CASE WHEN c.risk_category = 'No Risk' THEN c.inspection_count ELSE 0 END) AS no_risk_results,
    SUM(CASE WHEN c.risk_category = 'Low Risk' THEN c.inspection_count ELSE 0 END) AS low_risk_results,
    SUM(CASE WHEN c.risk_category = 'Moderate Risk' THEN c.inspection_count ELSE 0 END) AS medium_risk_results,
    SUM(CASE WHEN c.risk_category = 'High Risk' THEN c.inspection_count ELSE 0 END) AS high_risk_results,
    t.total_inspections
FROM counted c
JOIN totals t 
    ON c.inspection_type = t.inspection_type
GROUP BY c.inspection_type, t.total_inspections
ORDER BY t.total_inspections DESC;