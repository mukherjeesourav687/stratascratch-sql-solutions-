-- Problem: Risky Projects
-- Platform: StrataScratch
-- Difficulty: Medium

SELECT
    p.title,
    p.budget,
    CEIL(SUM(e.salary * DATEDIFF(p.end_date, p.start_date) / 365.0)) AS total_expense
FROM linkedin_projects p
JOIN linkedin_emp_projects ep
    ON p.id = ep.project_id
JOIN linkedin_employees e
    ON ep.emp_id = e.id
GROUP BY p.id, p.title, p.budget
HAVING CEIL(SUM(e.salary * DATEDIFF(p.end_date, p.start_date) / 365.0)) > p.budget;

-- Explanation:
-- Calculate prorated salary using (salary * project_duration / 365)
-- Sum total expense per project
-- CEIL() ensures rounding up to nearest dollar
-- Compare total expense with project budget
-- Return only overbudget (risky) projects