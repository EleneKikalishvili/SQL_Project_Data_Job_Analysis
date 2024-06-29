/*
Question: What are the most in-demand skills for data analysts?
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
  providing insights into the most valuable skills for job seekers.
*/

SELECT
    sk.skills,
    COUNT(sjd.job_id) AS demand_count
FROM 
    job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN 
    skills_dim AS sk ON sjd.skill_id = sk.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
GROUP BY
    sk.skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
Insights:
  This suggests that SQL, Python, and Tableau are not only crucial skills for 
  top data analyst roles but are also highly demanded skills overall for any data 
  analyst role. Excel ranks as the second most demanded skill, with Power BI 
  coming in fifth.

Results:
[
  {
    "skills": "sql",
    "demand_count": "92628"
  },
  {
    "skills": "excel",
    "demand_count": "67031"
  },
  {
    "skills": "python",
    "demand_count": "57326"
  },
  {
    "skills": "tableau",
    "demand_count": "46554"
  },
  {
    "skills": "power bi",
    "demand_count": "39468"
  }
]
*/