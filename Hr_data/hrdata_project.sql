create database hr_data;
use hr_data;
create table hrdata
(
emp_no int8 PRIMARY KEY,
gender varchar(50) NOT NULL,
marital_status varchar(50),
age_band varchar(50),
age int8,
department varchar(50),
education varchar(50),
education_field varchar(50),
job_role varchar(50),
business_travel varchar(50),
employee_count int8,
attrition varchar(50),
attrition_label varchar(50),
job_satisfaction int8,
active_employee int8
);
select * from hrdata;

load data infile "F:\hrdata.csv"
into table hrdata
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select sum(employee_count) as Total_Employees from hrdata
where education = 'High School';
where department = 'Sales' and education_field = 'Medical'
where education_field = 'Medical'

select count(attrition) as Attrition
from hrdata
where attrition ='Yes';

select sum(employee_count) - (select count(attrition) from hrdata where attrition ='Yes'and gender ='Male') as Active_Employees 
from hrdata where gender = 'Male';
select sum(employee_count) - (select count(attrition) from hrdata where attrition ='Yes'and gender ='Female') as Active_Employees 
from hrdata where gender = 'Female';

select round(((select count(attrition) from hrdata where attrition ='Yes')/ sum(employee_count))* 100,2) as attrition_rate
from hrdata;

select * from hrdata limit 10;

select round(avg(age),0)as Avg_Age from hrdata;

-- attrition by gender
select gender, count(attrition) as Attrition_by_Gender
from hrdata
where attrition = 'Yes' -- and education = 'High School'
group by gender
order by count(attrition) desc;

select department, count(attrition) as D_Attrition
from hrdata
where attrition = 'Yes'
group by department;

select department, count(attrition), 
round((cast(count(attrition)as numeric)/ (select count(attrition) as Attrition from hrdata where attrition ='Yes'))*100,2) as Department_wise_AttritionRate
from hrdata
where attrition ='Yes'
group by department;

select age_band,sum(employee_count) as Employees
from hrdata
group by age_band
order by Employees desc;

select education_field , count(attrition) as Attrition from hrdata
where attrition = 'Yes'
group by education_field
order by attrition desc;


select 
age_band ,count(attrition) from hrdata where attrition ='Yes' group by age_band AS age_attrition,
select(age_attrition)/sum(age_attrition)

select age_band, gender, count(attrition) as attrition,
(round(cast(count(attrition) as numeric)/(select count(attrition) as Attrition from hrdata where attrition ='Yes')*100,2))as  attrition_rate
from hrdata
where attrition = 'Yes'
group by age_band,gender
order by 1,2 desc;

select job_satisfaction from hrdata limit 4;

select job_role, count(job_satisfaction) as JobSatisfaction
from hrdata
group by job_role
order by 2 desc;

