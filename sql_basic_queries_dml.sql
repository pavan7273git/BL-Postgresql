
/*

--To count the number of columns in a table
select count(*) as column_count
from information_schema.columns
where table_schema='public'
and table_name='covid_data';

*/


-- DML are SELECT, INSERT, UPDATE, and DELETE
--  UPDATE Statements

--Update the recovered value for a specific country.
select * from covid_data;
select country_region ,recovered from covid_data where country_region='india'

-- postgresql is case-sensitive for strings,so eneter the names as it is in the table 
update covid_data set recovered=965000 where country_region ='India';


--Set the new_deaths to 0 where it's NULL.
select * from covid_data;

select country_region,new_deaths from covid_data where new_deaths is null;

--Increase all confirmed cases by 5% (simulate growth).
update covid_data set confirmed=confirmed*1.05;

--Update all countries in a specific WHO region to have deaths = 0 for test cases.
update covid_data set deaths=0 where who_region='Europe';

select who_region,country_region,deaths from covid_data 
where who_region='Europe';

--Update the active_cases column using the formula: confirmed - recovered - deaths.

update covid_data set active=confirmed-recovered-deaths;

--Update only the top 5 countries with the highest confirmed cases (with a subquery).

update covid_data set deaths=69 where country_region in (
select country_region from covid_data
order by confirmed desc limit 5);
