/* Question: What are tyhe highest paying skills?
- Calculate the median salary for each skill required
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Help us identify which skills command the highest pay
*/

SELECT 
    jpf.job_title_short,
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    count(jpf.*) AS demand_count 
FROM 
    job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim AS sjd
ON 
    jpf.job_id = sjd.job_id
INNER JOIN 
    skills_dim AS sd
ON 
    sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
AND 
    jpf.job_work_from_home = 'True'
GROUP BY 
    1, 2
HAVING
    count(jpf.*) >= 100
ORDER BY 
    demand_count DESC    

limit 5;

/* Query Result

┌─────────────────┬─────────┬───────────────┬──────────────┐
│ job_title_short │ skills  │ median_salary │ demand_count │
│     varchar     │ varchar │    double     │    int64     │
├─────────────────┼─────────┼───────────────┼──────────────┤
│ Data Engineer   │ sql     │      130000.0 │        29221 │
│ Data Engineer   │ python  │      135000.0 │        28776 │
│ Data Engineer   │ aws     │      137320.0 │        17823 │
│ Data Engineer   │ azure   │      128000.0 │        14143 │
│ Data Engineer   │ spark   │      140000.0 │        12799 │
└─────────────────┴─────────┴───────────────┴──────────────┘

Key TakeawaysMust-Have Skills: 
SQL and Python dominate the market. Together they appear in the vast majority of Data Engineer postings. You should be proficient in both.
Cloud Skills Split: AWS leads over Azure in both demand and salary. Knowing AWS gives you a noticeable edge right now.
Salary Leaders: Spark ($140k) offers the biggest pay premium.
AWS ($137k) follows closely.
Azure is the lowest paid in this group.

Demand vs Salary Pattern:
Highest volume skills (SQL, Python) have slightly lower salaries.
More specialized/big-data/cloud skills (Spark, AWS) carry higher median salaries.

Actionable AdvicePriority Learning Order for Data Engineers:
SQL — non-negotiable
Python — non-negotiable
AWS (or Azure if your target companies use Microsoft stack)
Spark — excellent for salary upside and big data roles

Mastering these five skills covers the vast majority of what recruiters are looking for in Data Engineer positions today.



*/