#US House-hold Income

#We'll first re-name the column in the statistics table as there is an diff column name in the place of ID.
SELECT * FROM us_project.us_household_income_statistics;

Alter table us_project.us_household_income_statistics Rename column `ï»¿id` to `ID`;

SELECT * FROM us_project.us_household_income;

#Now lets first take the count of both the table.

SELECT count(ID) FROM us_project.us_household_income_statistics;

SELECT count(row_id) FROM us_project.us_household_income;

# Now lets find out any duplicates in the data.alter

Select id, count(id)
from us_project.us_household_income
Group by id
Having count(id) >1;

Select *
from
(
Select row_id,
id,
Row_number() over(partition by id order by id ) row_num
from us_project.us_household_income 
) duplicates
where row_num >1;

Delete from us_project.us_household_income 
where row_id IN(
	Select row_id
	from(
		Select row_id,
		id,
		Row_number() over(partition by id order by id ) row_num
		from us_project.us_household_income 
		) duplicates
	where row_num >1);
    
    #Now we have removed all the duplicates.
    
select id, count(id)
from us_project.us_household_income_statistics
Group by id
Having count(id) >1;

#Now we free from duplicates and lets move on to next data cleaning process

SELECT * FROM us_project.us_household_income;

SELECT distinct state_name
FROM us_project.us_household_income
order by 1;

Update us_project.us_household_income
set state_name = 'Georgia'
where state_name = 'georia';

Update us_project.us_household_income
set state_name = 'Alabama'
where state_name = 'alabama';

SELECT distinct state_ab
FROM us_project.us_household_income
order by 1;

#Now lets check the missing details in any section

SELECT *
FROM us_project.us_household_income
where place = ''
order by 1;

SELECT *
FROM us_project.us_household_income
where county = 'Autauga County'
order by 1;

Update us_project.us_household_income
set place ='Autaugaville'
where county = 'Autauga County'
and city = 'Vinemont';

#Now lets check the county type in us_project.us_household_income
Select type, count(type)
from us_project.us_household_income
group by type;

Update us_project.us_household_income
set type = 'Borough'
where type = 'Boroughs';

Select * from us_project.us_household_income;

Select Aland, Awater
 from us_project.us_household_income
 where (Aland = 0 or aland = '' or aland is null)
 
 
 #Looks like we have cleaned the table and hence we have cleaned the table.