# HR Dashboard-MySQL-PowerBI
![hr report](https://github.com/Kyreddyy/portfolioprojects/assets/132040380/9e8cdd9c-ae53-41f6-b60c-5df1ccd5d02d)

## Data

**Data** - Human Resources Data with over 22000 rows from the year 2000 to 2020.

**Data Cleaning & Analysis** - MySQL Workbench

**Data Visualization** - PowerBI

## Findings

1. Gender breakdown of employees in the company
2. Race/ethnicity breakdown of employees in the company
3. Age distribution of employees in the company
4. Employees that worked at headquarters versus remote locations
5. Average length of employment for employees who have been terminated
6. Gender distribution across departments and job titles
7. Distribution of job titles across the company
8. Department that has the highest turnover rate
9. Distribution of employees across locations by state
10. Company's employee count change over time based on hire and term dates
11. Tenure distribution for each department

## Summary of Findings
 - There are more male employees
 - Dominant race -White, least dominant- Native Hawaiian and American Indian.
 - Youngest employee= 20 years and oldest = 57 years
 - 5 age groups were made (18-24, 25-34, 35-44, 45-54, 55-64). large number of employees->(25-34) followed by (35-44), smallest group -> (55-64).
 - As opposed to working remotely, many personnel are based in the headquarters.
 - The average length of employment for terminated employees ~ 7 years.
 - Although there is a fairly equal gender ratio across divisions, there are often more male than female employees.
 - The Marketing department has the highest turnover rate followed by Training.Research and development, Support and Legal departments has least turn over rate.
 - A large number of employees come from the state of Ohio.
 - The net change in employees has increased over the years.
- The average tenure for each department = 8 years, highest= Legal and Auditing departments and lowest= Services, Sales and Marketing departments.

## Limitations

- Some records had negative ages and these were excluded during querying(967 records). Ages used were 18 years and above.
- Some termdates were far into the future and were not included in the analysis(1599 records). The only term dates used were those less than or equal to the current date.
