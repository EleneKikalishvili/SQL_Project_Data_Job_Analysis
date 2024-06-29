/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest_paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
  helping job seekers understand which skills to develop that align with top salaries
*/


/* Solution 1. Listing all skills separately

WITH top_paying_jobs AS (
    SELECT
        postings.job_id,
        postings.job_title,
        postings.salary_year_avg,
        company_dim.name AS company_name
    FROM
        job_postings_fact AS postings
    LEFT JOIN 
        company_dim ON postings.company_id = company_dim.company_id
    WHERE
        postings.job_title_short = 'Data Analyst' AND
        postings.job_location = 'Anywhere' AND
        postings.salary_year_avg IS NOT NULL
    ORDER BY
        postings.salary_year_avg DESC
    LIMIT 10
)

SELECT 
    tpj.job_id,
    tpj.job_title,
    tpj.salary_year_avg,
    tpj.company_name,
    skills_dim.skills
FROM 
    top_paying_jobs AS tpj
INNER JOIN 
    skills_job_dim ON tpj.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    tpj.salary_year_avg DESC;

*/


-- Solution 2. Listing skills associated with each job in an array for efficiency and readability
WITH top_paying_jobs AS (
    SELECT
        postings.job_id,
        postings.job_title,
        postings.salary_year_avg,
        company_dim.name AS company_name
    FROM
        job_postings_fact AS postings
    LEFT JOIN 
        company_dim ON postings.company_id = company_dim.company_id
    WHERE
        postings.job_title_short = 'Data Analyst' AND
        postings.job_location = 'Anywhere' AND
        postings.salary_year_avg IS NOT NULL
    ORDER BY
        postings.salary_year_avg DESC
    LIMIT 10
)

SELECT 
    tpj.job_id,
    tpj.job_title,
    tpj.salary_year_avg,
    tpj.company_name,
    array_agg(sk.skills) AS skills -- Using array_agg to aggregate skills per job
FROM 
    top_paying_jobs AS tpj
INNER JOIN 
    skills_job_dim AS sjd ON tpj.job_id = sjd.job_id
INNER JOIN 
    skills_dim AS sk ON sjd.skill_id = sk.skill_id
GROUP BY 
    tpj.job_id, tpj.job_title, tpj.salary_year_avg, tpj.company_name
ORDER BY
    tpj.salary_year_avg DESC;

/*
Insights:
  The most frequently mentioned skills for the top data analyst roles in 2023 are 
  SQL, Python, and Tableau, indicating that proficiency in these areas is highly 
  valued for data analyst roles. 
  These are followed by other skills like R, Snowflake, Pandas, and Excel,
  reflecting the evolving landscape of data analysis where cloud solutions and 
  advanced data manipulation are becoming increasingly important.
  Also, Despite the rise of more advanced tools, Excel remains a key 
  skill due to its versatility and widespread use in various business environments.

Results:
[
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "salary_year_avg": "255829.5",
    "company_name": "AT&T",
    "skills": [
      "sql",
      "python",
      "r",
      "azure",
      "databricks",
      "aws",
      "pandas",
      "pyspark",
      "jupyter",
      "excel",
      "tableau",
      "power bi",
      "powerpoint"
    ]
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "skills": [
      "sql",
      "python",
      "r",
      "hadoop",
      "tableau"
    ]
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "skills": [
      "sql",
      "crystal",
      "oracle",
      "tableau",
      "flow"
    ]
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": [
      "sql",
      "python",
      "go",
      "snowflake",
      "pandas",
      "numpy",
      "excel",
      "tableau",
      "gitlab"
    ]
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": [
      "sql",
      "python",
      "azure",
      "aws",
      "oracle",
      "snowflake",
      "tableau",
      "power bi",
      "sap",
      "jenkins",
      "bitbucket",
      "atlassian",
      "jira",
      "confluence"
    ]
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": [
      "sql",
      "python",
      "r",
      "git",
      "bitbucket",
      "atlassian",
      "jira",
      "confluence"
    ]
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "skills": [
      "sql",
      "python",
      "go",
      "snowflake",
      "pandas",
      "numpy",
      "excel",
      "tableau",
      "gitlab"
    ]
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "salary_year_avg": "184000.0",
    "company_name": "Get It Recruit - Information Technology",
    "skills": [
      "sql",
      "python",
      "r"
    ]
  }
]
*/