/*DDL Commands in PostgreSQL
Command	  	Purpose
CREATE	  	Create a new table, view, index, schema, etc.
ALTER	  	Modify an existing table (add/drop/rename columns, change data types)
DROP	  	Delete a table or database object
TRUNCATE	Delete all rows from a table quickly (without logging individual row deletions)
RENAME	    Rename table or column (in PostgreSQL, it's done using ALTER)*/

-- alter comands
-- add column

--add new column to covid_data table

select * From covid_data;

-- to count the number of columns of a table
select count(*) as column_count from information_schema.columns
where table_schema='public' and table_name='covid_data'

alter table covid_data add column active_cases integer;

select count(*) from covid_data
where active_cases IS NULL;

-- drop column 
 -- remove the column active_cases from covid_data;

alter table covid_data
drop column active_cases;

  -- check the table for the dropped column
select * from covid_data;

  --or u can check the column count 
select count(*) as column_count
from information_schema.columns
where table_schema='public' and table_name ='covid_data'


--RENAME COLUMN
 -- rename column country_region to region

 alter table covid_data rename column country_region to country;

 --here u can check for the column county_region it gives error 
 select country from covid_data;

  --change datatype
 	-- change the data type of confirmed column from integer to bigint.

		--here u can check the column name and data type of column 
		select column_name,data_type
		from information_schema.columns
		where table_schema='public' and table_name ='covid_data'

	-- here u can change the column type using alter 
	 alter table covid_data alter column confirmed type bigint;

 --SET DEFAULT
 	--set default for column confirmed
   /* This sets the default value of the confirmed column to 0.
	New Rows Only: This change affects only the future INSERTS.

		If you insert a row and skip the confirmed column, PostgreSQL will automatically fill it with 0.

		It does not update any existing rows.

		If any row has NULL or other values in confirmed, those remain untouched.

		*/
	 alter table covid_data alter column confirmed set default 0;

	 --Drop default
	 --we can drop the default of a column

	 alter table covid_data
	 alter column confirmed drop default;

	-- here we can check the weather the column is set default or not
	SELECT column_name, column_default
	FROM information_schema.columns
	WHERE table_name = 'covid_data';

	--RENAME TABLE
	alter table covid_data rename to all_covid_data;

	select * from all_covid_data;
