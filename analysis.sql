
-- is there any employee under the age of 18 ?
select count(*) as `Count`
from hr
where age < 18;

-- what is the gender breakdoun in the company ?
select gender, count(*) as `Count`
from hr
where term_date = '0000-00-00'
group by gender;

-- what is the race/ethnicity breakdoun in the company ?
select race, count(*) as `Count`
from hr
where term_date = '0000-00-00'
group by race
order by `Count` desc;

-- what is age distribution in the company ?
-- the minimum age value: 21, the maximum age value: 58
select
  min(age) as Youngest,
  max(age) as Oldest
from hr
where term_date = '0000-00-00';

select 
  case
    when age >= 18 and age <= 24 then '18-24'
    when age >= 25 and age <= 34 then '25-34'
    when age >= 35 and age <= 44 then '35-44'
    when age >= 45 and age <= 54 then '45-54'
    when age >= 55 and age <= 64 then '55-64'
    else '65+'
  end as `age_group`,
  count(*) as `count`
from hr
where term_date = '0000-00-00'
group by `age_group`
order by `age_group`;

select 
  case
    when age >= 18 and age <= 24 then '18-24'
    when age >= 25 and age <= 34 then '25-34'
    when age >= 35 and age <= 44 then '35-44'
    when age >= 45 and age <= 54 then '45-54'
    when age >= 55 and age <= 64 then '55-64'
    else '65+'
  end as `age_group`,
  gender,
  count(*) as `count`
from hr
where term_date = '0000-00-00'
group by `age_group`, gender
order by `age_group`, gender;

-- how many employees work at headquarters versus remote locations ?
select location, count(*) as `count`
from hr
where term_date = '0000-00-00'
group by location;

-- what is the average length of employment for employees have been termimated ?
select 
  round(avg(datediff(term_date, hire_date))/365, 0) as employment_length_avg
from hr
where term_date <= curdate() and term_date != '0000-00-00';

-- how does the gender distribution vary across departments?
select department, gender, count(*) as `count`
from hr
where term_date='0000-00-00'
group by department, gender
order by department;

-- what is the distribution of job titles acroos the company ?
select jobtitle, count(*) as `count`
from hr
where term_date='0000-00-00'
group by jobtitle
order by jobtitle desc;

-- which department has the highest turnover rate ?
select department,
  total_count,
  terminated_count,
  terminated_count/total_count as term_rate
from (
  select department,
    count(*) as total_count,
    sum(case when term_date != '0000-00-00' and term_date!=curdate() then 1 else 0 end) as terminated_count
  from hr
  group by department
) as subq
order by term_rate desc;

-- what is the distribution of epmloyees across locations by city and state ?
select location_state, count(*) as `count`
from hr
where term_date != '0000-00-00'
group by location_state
order by `count` desc;

-- how has the company's employee count changed over time based on hire_date andterm_date ?
select
  `year`,
  hires,
  terminations,
  hires-terminations as net_change,
  round((hires-terminations)/hires*100, 2) as net_change_percent
from (
  select
    year(hire_date) as `year`,
    count(*) as hires,
    sum(case when term_date != '0000-00-00' and term_date <= curdate() then 1 else 0 end) as terminations
  from hr
  group by `year`
) as subq
order by `year` asc;

-- what is the tenure distribution for each department ?
select
  department,
  round(avg(datediff(term_date, hire_date)/365),0) as avg_department_tenure
from hr
where term_date <= curdate() and term_date != '0000-00-00'
group by department;

-- total headcount
select distinct count(*) as `total headcount`
from hr
where term_date = '0000-00-00';





