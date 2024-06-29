SELECT
    skills
FROM skills_dim
    INNER JOIN
    (
        SELECT
        skill_id
        FROM 
            skills_job_dim
        GROUP BY 
            skill_id
        ORDER BY 
            COUNT(skill_id) DESC
        LIMIT 5
    ) AS top_skills
    ON skills_dim.skill_id = top_skills.skill_id;

--Problem 2
SELECT
company_dim.name,
company_job_postings.company_id,
CASE
    WHEN company_job_postings.number_of_postings < 10 THEN 'Small'
    WHEN company_job_postings.number_of_postings BETWEEN 10 and 50 THEN 'Medium'
    WHEN company_job_postings.number_of_postings > 50 THEN 'Large'
END AS company_size
FROM 
    (
        SELECT
            company_id,
            COUNT(job_id) AS number_of_postings
        FROM
            job_postings_fact
        GROUP BY
            company_id
    ) AS company_job_postings
INNER JOIN 
    company_dim on company_dim.company_id = company_job_postings.company_id
ORDER BY company_id;

--Problem 3
SELECT
    company_avg_salaries.company_name,
    company_avg_salaries.avg_company_salary
FROM
    (
        SELECT
            DISTINCT postings.company_id,
            company_dim.name AS company_name,
            AVG(DISTINCT postings.salary_year_avg) AS avg_company_salary
        FROM
            job_postings_fact AS postings
            INNER JOIN
            company_dim on company_dim.company_id = postings.company_id
        WHERE 
            salary_year_avg IS NOT NULL
        GROUP BY
            postings.company_id,
            company_dim.name
        ORDER BY
            company_id
    ) AS company_avg_salaries
WHERE
    (
    SELECT
        AVG(salary_year_avg) AS avg_salary
    FROM
        job_postings_fact
    ) < company_avg_salaries.avg_company_salary;

--Problem 3 more efficient way
SELECT
    company_dim.name AS company_name,
    company_avg_salaries.avg_company_salary
FROM
    (
        SELECT
            DISTINCT company_id,
            AVG(DISTINCT salary_year_avg) AS avg_company_salary
        FROM
            job_postings_fact
        WHERE 
            salary_year_avg IS NOT NULL
        GROUP BY
            company_id
        ORDER BY
            company_id
    ) AS company_avg_salaries
    INNER JOIN
    company_dim on company_dim.company_id = company_avg_salaries.company_id
WHERE
    (
    SELECT
        AVG(salary_year_avg) AS avg_salary
    FROM
        job_postings_fact
    ) < company_avg_salaries.avg_company_salary;
