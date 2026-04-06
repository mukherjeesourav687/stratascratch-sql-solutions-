-- Problem: Finding Updated Records
-- Source: StrataScratch
-- ID: 10299
-- Difficulty: Easy

SELECT 
    e.id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
FROM ms_employee_salary e
JOIN (
    SELECT 
        id,
        MAX(salary) AS max_salary
    FROM ms_employee_salary
    GROUP BY id
) m
ON e.id = m.id 
AND e.salary = m.max_salary
ORDER BY e.id ASC;

-- Explanation:
-- Each employee may have multiple salary records (historical data)
-- We assume salary is non-decreasing over time
-- MAX(salary) gives the latest (current) salary per employee
-- We join back to get full employee details
-- Final result is ordered by employee ID