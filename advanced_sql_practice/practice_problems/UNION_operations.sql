--Problem 1
(
    SELECT 
        job_id,
        job_title,
        'with salary info' AS salary_info
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL
)

UNION ALL

(
    SELECT 
        job_id,
        job_title,
        'without salary info' AS salary_info
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NULL AND salary_hour_avg IS NULL
)

ORDER BY 
    salary_info DESC;

--Problem 2
(
    SELECT
    january_jobs.job_id,
    january_jobs.job_title_short,
    january_jobs.job_location,
    january_jobs.job_via,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM 
    january_jobs
    LEFT JOIN
    skills_job_dim 
    on january_jobs.job_id = skills_job_dim.job_id
    LEFT JOIN
    skills_dim
    on skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    salary_year_avg > 70000
)

UNION ALL

(
    SELECT
    february_jobs.job_id,
    february_jobs.job_title_short,
    february_jobs.job_location,
    february_jobs.job_via,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM 
    february_jobs
    LEFT JOIN
    skills_job_dim 
    ON february_jobs.job_id = skills_job_dim.job_id
    LEFT JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg > 70000
)

UNION ALL

(
    SELECT
    march_jobs.job_id,
    march_jobs.job_title_short,
    march_jobs.job_location,
    march_jobs.job_via,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM 
    march_jobs
    LEFT JOIN
    skills_job_dim 
    ON march_jobs.job_id = skills_job_dim.job_id
    LEFT JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg > 70000
)

--Problem 2 - better solution
SELECT
    job_postings_q1.job_id,
    job_postings_q1.job_title_short,
    job_postings_q1.job_location,
    job_postings_q1.job_via,
    job_postings_q1.salary_year_avg,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM
    (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    ) AS job_postings_q1
    LEFT JOIN
    skills_job_dim 
    ON job_postings_q1.job_id = skills_job_dim.job_id
    LEFT JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_q1.salary_year_avg > 70000
ORDER BY
    job_postings_q1.job_id;

--Problem 3
SELECT
    skills_dim.skills,
    COUNT(job_postings_q1.job_id),
    EXTRACT(YEAR FROM job_postings_q1.job_posted_date) AS year,
    EXTRACT(MONTH FROM job_postings_q1.job_posted_date) AS month
FROM
    (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    ) AS job_postings_q1
    LEFT JOIN
    skills_job_dim 
    ON job_postings_q1.job_id = skills_job_dim.job_id
    LEFT JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    year,
    month,
    skills_dim.skills
ORDER BY
    skills,
    year,
    month;

--another solution using CTEs

-- CTE for combining job postings from January, February, and March
WITH combined_job_postings AS (
  SELECT job_id, job_posted_date
  FROM january_jobs
  UNION ALL
  SELECT job_id, job_posted_date
  FROM february_jobs
  UNION ALL
  SELECT job_id, job_posted_date
  FROM march_jobs
),
-- CTE for calculating monthly skill demand based on the combined postings
monthly_skill_demand AS (
  SELECT
    skills_dim.skills,  
    EXTRACT(YEAR FROM combined_job_postings.job_posted_date) AS year,  
    EXTRACT(MONTH FROM combined_job_postings.job_posted_date) AS month,  
    COUNT(combined_job_postings.job_id) AS postings_count 
  FROM
    combined_job_postings
	  INNER JOIN skills_job_dim ON combined_job_postings.job_id = skills_job_dim.job_id  
	  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  
  GROUP BY
    skills_dim.skills, year, month
)
-- Main query to display the demand for each skill during the first quarter
SELECT
  skills,  
  year,  
  month,  
  postings_count 
FROM
  monthly_skill_demand
ORDER BY
  skills, year, month;  

/*
If you want to capture the demand for skills only 
(i.e., job postings with associated skills), 
the second query is more appropriate. 
If you need to account for all job postings, 
regardless of whether they list skills, 
the first query might be better.
*/