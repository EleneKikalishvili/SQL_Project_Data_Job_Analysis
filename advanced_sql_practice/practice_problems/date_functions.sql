--Problem 1
SELECT 
    AVG(salary_year_avg) AS avg_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary,
    job_schedule_type
FROM
    job_postings_fact
WHERE
    job_posted_date::DATE > 'June 1, 2023'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type ASC;

--Problem 2
SELECT
    COUNT(*),
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS post_month
FROM
    job_postings_fact
WHERE   
    EXTRACT(YEAR from job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    post_month
ORDER BY
    post_month;

--Problem 3
SELECT
    company_dim.name AS company_name,
    COUNT(*) AS job_postings_count
--    posts.job_title,
--    posts.job_health_insurance
FROM
    job_postings_fact AS posts
    INNER JOIN 
    company_dim on company_dim.company_id = posts.company_id
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023 AND
--    EXTRACT(MONTH FROM job_posted_date) IN (4,5,6) AND
    EXTRACT(QUARTER FROM posts.job_posted_date) = 2 AND
    job_health_insurance = TRUE
GROUP BY
    company_name
HAVING
    COUNT(*) >= 1
ORDER BY 
    job_postings_count DESC;
    


