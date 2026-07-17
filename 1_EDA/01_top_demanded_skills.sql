/* A query to get the most in-demand skills for remote data engineering roles in Nigeria
*/

SELECT 
    jpf.job_title_short, sd.skills, count(*) AS demand_count 
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
    jpf.job_country = 'Nigeria'
AND 
    jpf.job_work_from_home = 'True'
GROUP BY 
    1, 2
ORDER BY 
    demand_count DESC


limit 5;

/* Query Result

┌─────────────────┬────────────┬──────────────┐
│ job_title_short │   skills   │ demand_count │
│     varchar     │  varchar   │    int64     │
├─────────────────┼────────────┼──────────────┤
│ Data Engineer   │ python     │           66 │
│ Data Engineer   │ sql        │           61 │
│ Data Engineer   │ aws        │           47 │
│ Data Engineer   │ kubernetes │           32 │
│ Data Engineer   │ redshift   │           28 │
└─────────────────┴────────────┴──────────────┘

Key TakeawaysDominant Pair: 
Python + SQL are by far the most requested (66 and 61). These two form the absolute core for Data Engineer roles.
Cloud & Infrastructure Focus: AWS (47) is very prominent, followed by Kubernetes (32). This suggests many roles are looking for engineers who can build and run data platforms in cloud-native environments.
Specialized AWS Tooling: Redshift appearing in the top 5 highlights demand for AWS-specific data warehousing knowledge.

Quick Priority Ranking (for job market relevance)Python — Highest demand
SQL — Must-have
AWS — Major cloud advantage
Kubernetes — Modern deployment & scaling
Redshift — Nice-to-have for AWS-heavy companies

This set of skills paints a picture of companies wanting Python/SQL developers who can also handle cloud infrastructure (AWS + Kubernetes) and work with data warehouses.



*/