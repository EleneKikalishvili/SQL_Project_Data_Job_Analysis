--Problem 1
WITH job_titles_count AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS count
    FROM
        job_postings_fact 
    GROUP BY
        company_id
    ORDER BY
        count DESC
)

SELECT
    job_titles_count.count,
    company_dim.name
FROM
    job_titles_count
    INNER JOIN
    company_dim on company_dim.company_id = job_titles_count.company_id
ORDER BY
    job_titles_count.count DESC
LIMIT 10;

--Problem 2
WITH national_avg_salary AS (
    SELECT
        job_country,
        AVG(salary_year_avg) AS country_avg
    FROM
        job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL
    GROUP BY
        job_country
)

SELECT
    postings.job_id,
    company_dim.name AS company_name,
    postings.job_title,
    postings.job_country,
    EXTRACT(MONTH FROM postings.job_posted_date) AS posting_month,
    postings.salary_year_avg AS individual_salary,
    CASE   
        WHEN postings.salary_year_avg > national_avg_salary.country_avg THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_category
FROM
    job_postings_fact AS postings
    INNER JOIN national_avg_salary
    on postings.job_country = national_avg_salary.job_country
    INNER JOIN company_dim
    on company_dim.company_id = postings.company_id
WHERE
    postings.salary_year_avg IS NOT NULL
ORDER BY
    posting_month DESC;

--Problem 3
WITH unique_skills_count AS (
    SELECT
        company_dim.name AS company_name,
        company_dim.company_id,
        COUNT(DISTINCT skills.skill_id) AS unique_skills
    FROM
        job_postings_fact AS postings
        LEFT JOIN 
        skills_job_dim AS skills
        on postings.job_id = skills.job_id
        LEFT JOIN company_dim
        on company_dim.company_id = postings.company_id
    GROUP BY
        company_dim.name,
        company_dim.company_id

)

, company_max_salary AS (
    SELECT 
        postings.company_id,
        postings.job_id,
        MAX(postings.salary_year_avg) AS max_salary
    FROM
        job_postings_fact AS postings
        INNER JOIN 
        skills_job_dim AS skills
        on postings.job_id = skills.job_id
    WHERE
        salary_year_avg IS NOT NULL
    GROUP BY
        postings.company_id,
        postings.job_id
    HAVING
        COUNT(skills.skill_id) >=1
)

SELECT
    skills.company_name,
    skills.unique_skills,
    company_max_salary.max_salary
FROM
    unique_skills_count AS skills
    LEFT JOIN
    company_max_salary 
    on skills.company_id = company_max_salary.company_id
ORDER BY
    skills.company_name;
