create database project3;
use project3;

create table job_data
(
job_id int,
actor_id int,
`event` varchar(10),
`language` varchar(10),	
time_spent int,
org	varchar(5),
ds varchar(20)
);

INSERT INTO job_data (ds, job_id, actor_id, `event`, `language`, time_spent, org)
VALUES
  ('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
  ('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
  ('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
  ('2020-11-28', 23, 1005, 'transfer', 'Persian', 22, 'D'),
  ('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
  ('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
  ('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
  ('2020-11-25', 20, 1003, 'transfer', 'Italian', 45, 'C');
  
  drop table job_data;
  select * from job_data;

-- Calculate the number of jobs reviewed per hour per day for November 2020?

SELECT 
    ds, COUNT(job_id) AS jobs_reviewed
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds
ORDER BY ds;

-- Calculate 7 day rolling average of throughput

SELECT ds, count(event)
from job_data
group by ds
order by ds;

SELECT ds, AVG(COUNT(event)) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS throughput_7day_avg
FROM job_data
GROUP BY ds
ORDER BY ds;

-- Calculate the percentage share of each language in the last 30 days.

SELECT `language`,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage_share
FROM job_data
GROUP BY `language`;

-- Display duplicates from the table.

SELECT *
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY job_id, actor_id, event, language, time_spent, org, ds ORDER BY job_id) AS row_num
  FROM job_data
) AS duplicates
WHERE row_num > 1;







