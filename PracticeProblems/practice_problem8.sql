/* Find job postings from the first quater that have a salary greater than 70k
 - Combine job posting tables from the first quater of 2023
 - Gets job postings with an average yearly salary > 70,000
 */

SELECT
    quater1_job_postings.job_title_short,
    quater1_job_postings.job_location,
    quater1_job_postings.job_via,
    quater1_job_postings.job_posted_date::DATE,
    quater1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quater1_job_postings
WHERE
    quater1_job_postings.salary_year_avg > 70000 AND
    quater1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quater1_job_postings.salary_year_avg DESC