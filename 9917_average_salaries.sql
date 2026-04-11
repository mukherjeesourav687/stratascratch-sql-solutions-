-- Problem: Average Salaries
-- Platform: StrataScratch
-- Difficulty: Easy

SELECT
    department,
    first_name,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM employee;

-- Explanation:
-- We use a window function AVG() to calculate the average salary per department
-- PARTITION BY department ensures the average is calculated within each department
-- Each row shows employee salary along with their department's average salary