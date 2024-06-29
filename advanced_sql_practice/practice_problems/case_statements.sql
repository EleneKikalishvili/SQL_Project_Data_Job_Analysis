--Problem 1
SELECT
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 100000 THEN 'high_salary'
        WHEN salary_year_avg BETWEEN 60000 AND 99999 THEN 'standard_salary'
        WHEN salary_year_avg < 60000 THEN 'low_salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;

--Problem 2
SELECT
    COUNT(DISTINCT company_id),
    CASE
        WHEN posts.job_work_from_home = TRUE THEN 'WFH'
        ELSE 'on_site'
    END AS WFH_policy
FROM   
    job_postings_fact AS posts
GROUP BY
    WFH_policy;

--Problem 2 V2
SELECT
    COUNT(DISTINCT CASE WHEN job_work_from_home = TRUE THEN company_id END) AS wfh_companies,
    COUNT(DISTINCT CASE WHEN job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM
    job_postings_fact;

--Problem 3
SELECT
    job_id,
    salary_year_avg,
    CASE
        WHEN job_title ILIKE '%senior%' THEN 'Senior'
        WHEN job_title ILIKE '%lead%' OR job_title ILIKE '%manager%' THEN 'Lead/Manager'
        WHEN job_title ILIKE '%junior%' OR job_title ILIKE '%entry%'  THEN 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE
        WHEN job_work_from_home = TRUE THEN 'YES'
        ELSE 'NO'
    END AS remote_option
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
LIMIT 50;
