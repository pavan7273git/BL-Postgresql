-- this query used to view the tables in the database
select * from information_schema.columns 
where table_schema='public' and table_name='worldometer_data';

--JOINS
 -- INNER JOIN	Only matching rows from both tables

 -- Get the list of countries that appear in both country_wise_latest and worldometer_data, and show their total confirmed cases and population.
 select * from covid_data;
 select * from worldometer_data;

alter table worldometer_data rename column "Country/Region" to country;

 select wd."country",wd."Population",cd."confirmed" from covid_data as cd
 inner join "worldometer_data" as wd on cd."country"=wd."country";

 SELECT wd.country, wd."Population", cd.confirmed
FROM covid_data AS cd
INNER JOIN worldometer_data AS wd ON cd.country = wd.country;

--List each country and date from full_grouped with their continent from worldometer_data.
select * from worldometer_data;
select * from full_grouped;

select fg.country,fg."Date" ,wd.who_region from full_grouped fg
inner join worldometer_data wd on fg.country=wd.country;

--From covid_19_clean_complete, join with worldometer_data to show the country, date, confirmed cases, and population.
select * from covid_19_complete;
select * from worldometer_data;

alter table covid_19_complete rename column "Country/Region" to country;

select c.country,c."Date",c."Confirmed",wd."Population"
from covid_19_complete c inner join worldometer_data wd 
on c.country=wd.country order by c.country desc;

select c.country,c."Date",c."Confirmed", wd."Population"
from covid_19_complete c inner join worldometer_data wd on c.country=wd.country where c.country in (select distinct(c.country) from covid_19_complete) 
order by c.country desc;

--Join country_wise_latest and worldometer_data to find countries where both death rate and population are available.
select * from information_schema.tables
where table_schema='public'

select * from covid_data;
select * from worldometer_data;

select wd.country,wd."Population",cd.deaths_per_100_cases
from covid_data cd join worldometer_data wd on cd.country=wd.country
where wd."Population" is not null and cd.deaths_per_100_cases is not null;


--From full_grouped, display country, date, and number of new cases along with the country's population.
select * from full_grouped;
select * from worldometer_data;

select wd.country,fg."Date",wd."Population",fg."New cases"
from worldometer_data wd join full_grouped fg using(country) order by fg.country ;