-- Problem: Income By Title and Gender
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. Aggregate total bonus per employee
-- 2. Join with employee table
-- 3. Calculate total compensation (salary + bonus)
-- 4. Take average grouped by title and gender
-- 5. Ignore employees without bonus using INNER JOIN

SELECT
    e.employee_title,
    e.sex,
    AVG(e.salary + b.total_bonus) AS avg_total_compensation
FROM sf_employee e
INNER JOIN (
    SELECT
        worker_ref_id,
        SUM(bonus) AS total_bonus
    FROM sf_bonus
    GROUP BY worker_ref_id
) b
ON e.id = b.worker_ref_id
GROUP BY e.employee_title, e.sex
ORDER BY e.employee_title, e.sex;