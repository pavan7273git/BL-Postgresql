--  Basic SQL Queries
--  DQL(Data Query Language)- select,where,group by , order by, having

-- 1. Retrieve all columns from the dataset.
select * from covid_data;

--Show only Province_State, Admin2, and Confirmed columns.
select province_state, Admin2 ,Confirmed from covid_data;


-- it gives the structure of the table
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'covid_data';

-- Retrieve all columns from country_wise_latest.

select * from covid_data;

-- Select only Country/Region, Confirmed, and Deaths for analysis.

select country_region,confirmed, deaths from covid_data;

--Find all unique WHO regions in the dataset.
select distinct(who_region) from covid_data; 

-- Retrieve countries where Confirmed cases are greater than 1,000,000.

select country_region as country_names from covid_data where confirmed>1000000;

-- Get all data for "Italy" where 1 week % increase > 10%.

select * from covid_data where country_region='italy' and one_week_percent_increase>1;

select country_region from covid_data where country_region ='italy'; 


--Count the total number of records in the dataset.

select count(*) from covid_data;

-- Find the average death rate per country.

select country_region, sum(deaths) *100 / (select sum(deaths) from covid_data) as average_deaths from covid_data group by country_region order by average_deaths desc;

-- Get the top 5 countries with the highest number of Confirmed cases.
select country_region,confirmed from covid_data
order by confirmed desc limit 5;

--Retrieve countries with more than 100,000 confirmed cases AND a death rate above 5%.
select * from covid_data where 
confirmed>100000 and deaths_per_100_cases>5;

--Show countries where Recovered cases are more than 80% of total confirmed cases.
select country_region,recovered,confirmed,(recovered * 100/confirmed) as rate from covid_data 
where recovered>0.8*confirmed order by rate desc;

--Retrieve the total confirmed cases per WHO region, but only include regions with more than 1,000,000 confirmed cases.
select who_region,sum(confirmed) as confirmed_cases from covid_data 
group by who_region having sum(confirmed)>1000000;

-- Count the number of countries in each WHO region and display only those regions having more than 10 countries.

select who_region,sum(country_region) from covid_data 
group by who_region having sum(country_region)>10;

-- Find countries where both the total confirmed cases exceed 1 million AND the death rate is above 5%.


select country_region,sum(confirmed) as total_cases,
(sum(deaths) * 100.0) /(select sum(deaths) from covid_data ) as death_rate  from covid_data 
group by country_region having sum(confirmed)>1000000
and  sum(deaths) * 100.0 /(select sum(deaths) from covid_data)
>5;

-- Retrieve the total number of confirmed and recovered cases per WHO region, but only display regions where recovered cases are at least 80% of total confirmed cases.

select * from covid_data;

select who_region ,sum(confirmed) as total_confirmed ,sum(recovered) as total_recovered from 
covid_data  group by who_region having sum(recovered)>=0.8*(sum(confirmed));


-- GET THE TOTAL DEATHS AND NEW DEATHS PER COUNTRY, BUT SHOW ONLY THOSE WHERE THE NUMBER OF NEW DEATHS IS MORE THAN 10% OF TOTal deaths.
select * from covid_data;

select country_region,sum(deaths) as total_deaths,sum(new_deaths) 
from covid_data group by country_region 
having sum(new_deaths)>0.1*(sum(deaths));
