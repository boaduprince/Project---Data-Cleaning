--  DATA CLEANING 

-- 1 remove duplicates
-- 2 standardize data
-- 3 null or blank values
-- 4 remove unnecessary rows and columns

select *
from layoffs;

-- creating a duplicate world_staging to keep the raw data safe
create table layoffs_staging
like layoffs; 

select * 
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;




-- 1 REMOVING DUPLICATES

select *,
row_number() over( 
partition by company,industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

with duplicate_cte as
(select *,
row_number() over( 
partition by company, location,industry, total_laid_off,
 percentage_laid_off, `date`,stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num >1;

select *
from layoffs_staging
where company = 'casper';

-- now we want to delete some columns so we create a duplicate table of layoffs_staging as layoffs_staging2 to keep the original table safe
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from layoffs_staging2
where row_num>1;

insert into layoffs_staging2
select *,
row_number() over( 
partition by company, location,industry, total_laid_off,
 percentage_laid_off, `date`,stage, country, funds_raised_millions) as row_num
from layoffs_staging;

delete 
from layoffs_staging2
where row_num>1;

select * 
from layoffs_staging2;




-- 2 STANDARDISING DATA CORRECTING AND REMOVING EMPTY SPACES
-- trim removes any whitespaces before and afterany company name
select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);
-- we check now, all those white spaces are gone

select distinct industry
from layoffs_staging2
order by 1;

select distinct industry
from layoffs_staging2
order by 1;

-- crypto seem to have differnt variation so we standardise it
select *
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry= 'crypto'
where industry like 'crypto%'
;

-- checking if there are any issues location column
select distinct location
from layoffs_staging2
order by 1;
  -- seems we are all good
  
  -- the country United States seem to have variations, 'United States' and 'United States.' so we standardize it
select distinct country 
from layoffs_staging2 
where country like 'united states%'
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2 
order by 1;

update layoffs_staging2
set country =trim(trailing '.' from country)
where country like  'united states%';

select `date`
from layoffs_staging2;
-- it looks cool now

-- moving into the date column, we change the date format
select `date`,
str_to_date(`date`,'%d/%m/%Y')
from layoffs_staging2;

-- we use str to date to update this column
update layoffs_staging2
set `date`= str_to_date(`date`,'%d/%m/%Y');

-- now we change data type from integer to date
alter table layoffs_staging2
modify column `date` DATE;

-- viewing the whole table,everything looks great
select * 
from layoffs_staging2;





-- 3 removing null or blank values

-- the null values in total_laid_off, percentage_laid_off, and funds_raised_millions all look normal. 
-- having them null makes it easier for calculations during the EDA phase
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- set all blanks to nulls since they are easier to work with
update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '' ;

select *
from layoffs_staging2
where  company like 'Bally%';
-- nothing wrong here

select *
from layoffs_staging2
where  company like 'airbnb%';

-- it looks like airbnb is a travel industry, but this one isn't populated.
-- It looks the same for the others.
-- we write a query that if there is another row with the same company name, it will update it to the non-null industry values
-- makes it easy so if there were thousands we wouldn't have to manually check them all

-- we populate those nulls
select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
     on t1.company = t2.company
     and t1.location = t2.location
     where t1.industry is null
     and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
      on t1.company = t2.company
      set t1.industry = t2.industry 
 where t1.industry is null 
     and t2.industry is not null;

select *
from layoffs_staging2;




-- 4 removing empty columns and rows
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- deleting any unwanted data
delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

-- we drop any column we added
alter table layoffs_staging2
drop column row_num;

select * 
from layoffs_staging2;






























































