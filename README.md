# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/).
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs

Data hails from my [SQL Course](https://lukebarousse.com/sql). It's full with insights on job titles, salaries, locations, and essential skills

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my in depth exploration into the data analyst job market, I utilized several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and discover critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Necessary for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I appraoched each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst postions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
Heres the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** The top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are amoung those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data analyst to Director of Analystics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\e54b1301-1b5e-4abd-ac28-0fa3cec33780.png)
*Bar graph visualizing the salary for the top 10 salaries for data analyst; ChatGPT generated this graph from my SQL query results*

### 2. Skills Required For Top-Paying Jobs
Using the preivous query of highest-paying jobs I dove deeper into the skills these high paying positions. This query focuses on the demanded skills of a high-paying postion.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
Some key inights of the data:
- **SQL/Python** show a great deal of importance in high-paying roles and are amoung the most in demand skills.
- **Tableau/R** provide value for data visualization and statistical analysis and are highly valued.
- **Azure/AWS** were metioned frequently showcase the importance of cloud infrastructure.

![Top Paying Job Skills](assets\98d659d0-74a3-4e0a-a999-725a602bc72a.png)
*Bar graph to help visualize skills for top paying Data Analyst postions; ChatGPT generated this graph from my SQL query results.*

### 3. High-Demand Skills for Data Analyst
In this query you will find the most frequently requested skills in job postings with focus on the high demand skills.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Here is a breakdown of the most demanded skills in 2023:

- **Python** and **Excel** lead the industry as the fundemtmental skills in data process and manuplation of spreesheets.
- Visualization tools like **Python**, **Tableau**, and **Power BI** are showing great demand and importance of technical skills in data storytelling along with decision insights.

| Skill      | Demand Count |
|------------|--------------|
| SQL        | 7,291         |
| Excel      | 4,611         |
| Python     | 4,330         |
| Tableau    | 3,745         |
| Power BI   | 2,609         |

*Table of the demand for the top 5 skill for data analyst job postings*

### 4. Skills Based on Salary
When exploring average salaries dependant on skills it revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
```
Here is a break down of skills in relation to salary:

- **High Demand for Big Data/ML Skills:**These top salaries for data analyst were skilled in big data technologies such as (Couchbase,Pyspark), ML tools such as (Data Robot,Jupyter), and Python libraries (Pandas,NumPy). 
- **Collaberation and Version Control:** skills in development and deployment tools such as (GitLab,Kubernetes,Airflow) show a crossover of data analysis and engeneering, which inflates the necessity on skills of automation and data pipeline management.
- **Cloud Computing:** cloud and data engneering tools (Elasticsearch, Databricks, GCP) shows the growing importance of cloud based analytics.

| Rank | Skill             | Avg Salary ($) |
|------|-------------------|----------------|
| 1    | PySpark            | 208,172        |
| 2    | Bitbucket          | 189,155        |
| 3    | Couchbase          | 160,515        |
| 4    | Watson             | 160,515        |
| 5    | DataRobot          | 155,486        |
| 6    | GitLab             | 154,500        |
| 7    | Swift              | 153,750        |
| 8    | Jupyter            | 152,777        |
| 9    | Pandas             | 151,821        |
| 10   | Elasticsearch       | 145,000        |
| 11   | Golang              | 145,000        |
| 12   | NumPy               | 143,513        |
| 13   | Databricks          | 141,907        |
| 14   | Linux               | 136,508        |
| 15   | Kubernetes          | 132,500        |
| 16   | Atlassian           | 131,162        |
| 17   | Twilio              | 127,000        |
| 18   | Airflow             | 126,103        |
| 19   | Scikit-learn        | 125,781        |
| 20   | Jenkins             | 125,436        |
| 21   | Notion              | 125,000        |
| 22   | Scala               | 124,903        |
| 23   | PostgreSQL          | 123,879        |
| 24   | GCP                 | 122,500        |
| 25   | MicroStrategy        | 121,619        |

*Table of average salary of top 25 paying skills for data analyst*

### 5. Most Optimal Skills to Learn

With combined insights of demand and salary data this query can identify skills in high demand along with high salaries.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE  
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Here is a breakdown of the most optimal skills for a Data Analyst in 2023.

- **High Demand & Salary:** Python and R are highly demanded with a count of 236 and 148 respectively. Although demand is high the average salaries for Python are around $101,397 and $100,499 for R showing there is value in these langueges but that they are also widely avalible.
- **Cloud Tools & Tech:** Cloud technologies such as Snowflake, Azure, AWS, and BigQuery show relatively high salaries which show importance of cloud platforms.
- **Business Intelligence and Visualization Tools:** Tableau and Looker have demand counts of 230 and 49 respectively. The salaries of $99,288 and $103,795 put the visualization and business intelligence into perspective showing these are critical roles when gathering insights from data.


| Skill         | Demand Count | Avg Salary ($) |
|---------------|--------------|----------------|
| Go            | 27           | 115,320        |
| Confluence     | 11           | 114,210        |
| Hadoop         | 22           | 113,193        |
| Snowflake      | 37           | 112,948        |
| Azure          | 34           | 111,225        |
| BigQuery        | 13           | 109,654        |
| AWS            | 32           | 108,317        |
| Java           | 17           | 106,906        |
| SSIS            | 12           | 106,683        |
| Jira           | 20           | 104,918        |
| Oracle         | 37           | 104,534        |
| Looker         | 49           | 103,795        |
| NoSQL           | 13           | 101,414        |
| Python         | 236          | 101,397        |
| R              | 148          | 100,499        |
| Redshift        | 16           | 99,936         |
| Qlik            | 13           | 99,631         |
| Tableau         | 230          | 99,288         |
| SSRS            | 14           | 99,171         |
| Spark           | 13           | 99,077         |
| C++             | 11           | 98,958         |
| SAS             | 63           | 98,902         |
| SQL Server      | 35           | 97,786         |
| JavaScript       | 20           | 97,587         |
# What I Learned

Throughout this project, I've learned and aquired new skills in SQL allowing me to expand my toolkit when tasked:

- 🖥️**Complex Query Crafting:** Working through advance SQl querys where it involved merging tables and utilizing WITH clauses for temp table maneuvers.
- 📊**Data Aggregation:** Using GROUP BY and aggregate fuctions like COUNT() or AVG() to summarize data that can be easily interpreted.
- 💡**Analystical:** Improving my problem solving skills with real-world data maniplation. This allowed me to answer questions with insightful SQL queries.

# Conclusions

### Insights
1. **Top-Paying Data Analyst Jobs**: Some of the highest-paying jobs for data analyst have a wide range of salries with some of the highest at $650,000. 
2. **Skills for Top-Paying Jobs**: The highest-paying postions for data analyst require proficency in SQL which imply that it's a critical skill for a top salary.
3. **Most In-Demand Skills**: SQL is also highly demanded within the job market making it essential for any job seeker.
4. **Skills with Higher Salaries**: With more specialized skills such as SVN and Solidity it offers an more incentivizing salary to complement the niche expertise.
5. **Optimal Skills for Job Market Value**: SQL shows high demand and offers a high average salary. This gives it the a standing as one of the most optimal skills for data analyst to learn so that they can increase their market value.

### Closing Thoughts

This project helped with my understanding of SQL and improved my skills which allowed me to be more confident with data manipulation. The findings also provided some insights into data analyst job market. These insights can serve as a guide and allow me to prioritize skill devlopments and job search efforts. The insights do this by focusing on high-demand/high-salary skills which allows for a more stratigic aproach for an aspiring data analyst like myself. This project highlights the importance of consistent learning to improve and adaptation to new trends in the field of data analytics.
