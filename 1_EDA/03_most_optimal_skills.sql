/* 
Question: What are the most optimal skills for data engineers?
- Create a ranking column that combines demand count 
and median salary to identify the most valuable skills
- Focus only on remote data engineering roles with specified annual salaries
- Why? this approach hughlights skills that balance market demand and financial reward. 
*/

SELECT 
    jpf.job_title_short,
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    count(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 0) AS ln_median_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_000_000, 2) AS demand_score
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
    demand_score DESC    

limit 5;

/* Query Result

┌─────────────────┬───────────┬───────────────┬──────────────┬─────────────────┬──────────────┐
│ job_title_short │  skills   │ median_salary │ demand_count │ ln_median_count │ demand_score │
│     varchar     │  varchar  │    double     │    int64     │     double      │    double    │
├─────────────────┼───────────┼───────────────┼──────────────┼─────────────────┼──────────────┤
│ Data Engineer   │ terraform │      184000.0 │         3248 │             8.0 │         1.49 │
│ Data Engineer   │ python    │      135000.0 │        28776 │            10.0 │         1.39 │
│ Data Engineer   │ airflow   │      150000.0 │         9996 │             9.0 │         1.38 │
│ Data Engineer   │ sql       │      130000.0 │        29221 │            10.0 │         1.34 │
│ Data Engineer   │ aws       │      137320.0 │        17823 │            10.0 │         1.34 │
└─────────────────┴───────────┴───────────────┴──────────────┴─────────────────┴──────────────┘

Key Takeaways

Highest Value Skill Right Now: Terraform  It offers the biggest salary boost (+$49k over base SQL).  
Even with lower volume, its demand_score (1.49) is the highest — meaning it gives you the best "bang for the buck" in the market.

Core Foundations vs Specialized Tools  SQL + Python = highest demand (28k–29k postings) → essential for getting interviews.  
Terraform + Airflow = higher salary tiers → strong differentiators once you're in the pool.

Cloud Matters

AWS sits nicely in the middle — very good demand + solid pay. Knowing at least one major cloud (AWS/Azure/GCP) is basically mandatory.
Demand Score Ranking (most to least valuable overall):Terraform (1.49)
Python (1.39)
Airflow (1.38)
SQL / AWS (1.34)

Actionable Advice for Data EngineersMust-have: 

SQL + Python
High-ROI to learn next: Terraform (biggest salary jump) and Airflow
Strong supporting skill: AWS (or equivalent cloud)

If you learn Terraform + Airflow + Python + SQL + AWS, you’re covering both the highest-paying and highest-demand areas in the Data Engineer market right now.


*/