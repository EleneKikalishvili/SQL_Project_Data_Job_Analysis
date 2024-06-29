SELECT
    COUNT(job_id),
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
GROUP BY
    month    
LIMIT 5;