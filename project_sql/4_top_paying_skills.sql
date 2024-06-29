/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and 
  helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    sk.skills,
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
    sk.skills
ORDER BY
    avg_salary DESC
LIMIT 25;



/*
Insights:
  A combination of data engineering, data science, programming, cloud, and DevOps skills 
  can significantly enhance a data analyst's earning potential. Proficiency in specific 
  high-paying tools and technologies can also provide a substantial salary boost.

  Here is a breakdown of high-paying skills and tools for data analysts: 
  Enabling Efficient Data Handling, Advanced Analysis, and Effective Project Management
  
  - Mastery of big data technologies like PySpark, Couchbase, and Databricks enables 
    efficient handling and analysis of large datasets. 
  - Data science and machine learning tools such as Jupyter, Pandas, NumPy, Scikit-learn, 
    Watson, and DataRobot are crucial for advanced data manipulation, interactive analysis, 
    and implementing machine learning models. 
  - Programming languages like Swift, Golang, and Scala are essential for developing 
    scalable applications. 
  - Knowledge of cloud platforms (GCP), DevOps tools (GitLab, Jenkins, Kubernetes), 
    and workflow automation (Airflow) enhances the ability to manage and deploy 
    data projects efficiently. 
  - Skills in project management (Atlassian, Notion), source code collaboration (Bitbucket), 
    communication tools (Twilio), and business intelligence (MicroStrategy) are valuable 
    for organizing, managing, and presenting data insights effectively. 
  - Foundational skills in Linux and PostgreSQL remain crucial for managing data infrastructure 
    and databases.

Results:
[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_salary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skills": "gcp",
    "avg_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "121619"
  }
]
*/