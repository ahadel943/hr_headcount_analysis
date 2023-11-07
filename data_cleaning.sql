use company;

set sql_safe_updates = 0;

alter table hr
change column id emp_id varchar(20) null;

-- change birth_date date format to sql date format - yyyy-mm-dd -
update hr
set birth_date = case
  when birth_date like '%/%' then date_format(str_to_date(birth_date, '%m/%d/%Y'), '%Y-%m-%d')
  when birth_date like '%-%' then date_format(str_to_date(birth_date, '%m-%d-%Y'), '%Y-%m-%d')
  else null
end;

alter table hr
modify column birth_date date;

select birth_date from hr;

-- change hire_date date format to sql date format - yyyy-mm-dd -

update hr
set hire_date = case
  when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
  when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%y'), '%Y-%m-%d')
  else null
end;

alter table hr
modify column hire_date date;

select hire_date from hr;

-- change the trem_date format sql date format - yyyy-mm-dd -
update hr
set term_date = date(str_to_date(term_date, '%Y-%m-%d %H:%i:%s UTC'))
where term_date is not null and term_date != ' ';

alter table hr
modify column term_date date;

select term_date from hr;

-- ang age column is needed in our analysis, creating age column  
alter table hr
add column age int;

-- populating the age column with date 
update hr
set age = timestampdiff(year, birth_date, curdate());

-- check
describe hr;
select birth_date, age from hr;
select * from hr limit 5;

