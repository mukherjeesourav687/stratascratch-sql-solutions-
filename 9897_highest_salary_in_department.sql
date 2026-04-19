-- Problem: Highest Salary In Department
-- Platform: StrataScratch
-- Difficulty: Medium

-- Approach:
-- 1. For each department, find the maximum salary
-- 2. Use a correlated subquery to compare each employee’s salary
-- 3. Return employees whose salary equals the department’s max
-- 4. Output department, first name, and salary

SELECT
    e.department,
    e.first_name,
    e.salary
FROM employee e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE department = e.department
);