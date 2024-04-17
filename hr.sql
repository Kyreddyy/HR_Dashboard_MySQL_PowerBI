select * from hr;
alter table hr
change column ï»¿id emp_id varchar(20) null;
describe hr;

set sql_safe_updates = 0;
update hr
set birthdate = case
  when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d' )
  when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d' )
  else Null
end;

alter table hr
modify column birthdate date;

select birthdate from hr;


update hr
set hire_date = case
  when hire_date like '%/%' then date_format( str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
  when hire_date like '%-%' then date_format( str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
  else NULL
end;

alter table hr
modify column hire_date date;

select hire_date from hr;

update hr
set termdate =
  if(termdate is not null and termdate !='',date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
  where true;
  
set sql_mode= 'allow_invalid_dates';
alter table hr
modify column termdate date;

alter table hr add column age int;
update hr
 set age = timestampdiff(year, birthdate, curdate());
select birthdate,age from hr;

#1Gender breakdown of employees in the company

select gender, count(*) as count  from hr 
where age>=18 and termdate = '0000-00-00' group by gender;

#2Race/ethnicity breakdown of employees in the company
SELECT race, count(*) AS count FROM hr
WHERE age>=18 AND termdate = '0000-00-00' GROUP BY race ORDER BY count(*) DESC;

#3Age distribution of employees in the company
select min(age), max(age) from hr
WHERE age>=18 AND termdate = '0000-00-00';

SELECT 
 CASE 
   WHEN age>= 18 AND age<=24 THEN '18-24'
   WHEN age>= 25 AND age<=34 THEN '25-34'
   WHEN age>= 35 AND age<=44 THEN '35-44'
   WHEN age>= 45 AND age<=54 THEN '45-54'
   WHEN age>= 55 AND age<=64 THEN '55-64'
   ELSE '65+'
 END AS age_group, count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group 
ORDER BY age_group;

SELECT 
 CASE 
   WHEN age>= 18 AND age<=24 THEN '18-24'
   WHEN age>= 25 AND age<=34 THEN '25-34'
   WHEN age>= 35 AND age<=44 THEN '35-44'
   WHEN age>= 45 AND age<=54 THEN '45-54'
   WHEN age>= 55 AND age<=64 THEN '55-64'
   ELSE '65+'
 END AS age_group,gender, count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

#4Employees that work at headquarters versus remote locations
SELECT location, count(*) as count from hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY location;

#5Average length of employment for employees who have been terminated
SELECT ROUND(AVG(datediff(termdate,hire_date))/365,0) AS avg_lenght_employement FROM hr 
WHERE age>=18 AND termdate != '0000-00-00'AND termdate<= curdate();

#6Gender distribution across departments and job titles
SELECT department, gender, count(*) AS count from hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

#7Distribution of job titles across the company
SELECT jobtitle, count(*) AS count from hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

#8Department that has the highest turnover rate
SELECT department, total_count,terminated_count,
terminated_count/total_count AS termination_rate 
FROM (
  SELECT department, count(*) AS total_count, SUM( CASE WHEN termdate!='0000-00-00' 
  AND termdate<= curdate() THEN 1 ELSE 0 END) AS terminated_count FROM hr WHERE age>=18
  GROUP BY department) AS subquery
ORDER BY termination_rate DESC;

#9Distribution of employees across locations by city and state
SELECT location_state, count(*) AS count from hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

#10Company's employee count change over time based on hire and term dates
SELECT year,hires,terminations,hires-terminations AS net_change,
round((hires-terminations)/hires*100,2) AS net_change_percentage
FROM ( SELECT YEAR(hire_date) AS year, count(*) AS hires, 
SUM(CASE WHEN termdate!='0000-00-00' AND termdate<= curdate() THEN 1 ELSE 0 END) AS terminations
FROM hr WHERE age>=18 
GROUP BY year) AS subquery
ORDER BY year ASC;

#11Tenure distribution for each department
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure from hr
WHERE age>=18 AND termdate<= curdate() AND termdate!= '0000-00-00'
GROUP BY department;





