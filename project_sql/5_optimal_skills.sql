/*
Question: What are the most optimal skills to learn (aka it’s in high demand 
          and a high-paying skill) for a data analyst?
- Identify skills in high demand and associated with high average salaries 
  for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial 
  benefits (high salaries), offering strategic insights for career 
  development in data analytics
*/

WITH skill_statistics AS (
    SELECT
        sk.skill_id,
        sk.skills,
        COUNT(sjd.job_id) AS demand_count,
        ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact AS jpf
    INNER JOIN 
        skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN 
        skills_dim AS sk ON sjd.skill_id = sk.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = TRUE
    GROUP BY
        sk.skill_id, sk.skills
)

SELECT
    skill_id,
    skills,
    demand_count,
    avg_salary
FROM
    skill_statistics
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
