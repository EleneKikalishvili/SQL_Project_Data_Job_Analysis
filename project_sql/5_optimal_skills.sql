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

/*
Insights:
 The demand for these skills reflects the ongoing trends in cloud computing, big data, 
 machine learning, and web development. These skills are highly valued in the tech industry, 
 and mastering them can lead to lucrative career opportunities.
 
 Top skills by demand count are:
    Python
        Demand Count: 236
        Average Salary: $101,397
    R
        Demand Count: 148
        Average Salary: $100,499
    Tableau
        Demand Count: 230
        Average Salary: $99,288
    Looker
        Demand Count: 49
        Average Salary: $103,795

Skills that are in the top 10 for both demand and salary:
    Go
        Demand Count: 27
        Average Salary: $115,320
    Snowflake
        Demand Count: 37
        Average Salary: $112,948
    Azure
        Demand Count: 34
        Average Salary: $111,225
    AWS
        Demand Count: 32
        Average Salary: $108,317

Results:
[
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "avg_salary": "115320"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "demand_count": "11",
    "avg_salary": "114210"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "22",
    "avg_salary": "113193"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "37",
    "avg_salary": "112948"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "34",
    "avg_salary": "111225"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "13",
    "avg_salary": "109654"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "32",
    "avg_salary": "108317"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "17",
    "avg_salary": "106906"
  },
  {
    "skill_id": 194,
    "skills": "ssis",
    "demand_count": "12",
    "avg_salary": "106683"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "avg_salary": "104918"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "37",
    "avg_salary": "104534"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "49",
    "avg_salary": "103795"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "13",
    "avg_salary": "101414"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "236",
    "avg_salary": "101397"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "148",
    "avg_salary": "100499"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "16",
    "avg_salary": "99936"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "demand_count": "13",
    "avg_salary": "99631"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "230",
    "avg_salary": "99288"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "demand_count": "14",
    "avg_salary": "99171"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "13",
    "avg_salary": "99077"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "demand_count": "11",
    "avg_salary": "98958"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "35",
    "avg_salary": "97786"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "20",
    "avg_salary": "97587"
  }
]
*/