use Portfilo_Project;
show tables;

select * from covid_deaths_filtered;

Select location, date, total_cases, new_cases, total_deaths, population
from covid_deaths_filtered
order by location, `date`;

-- Looking at Total Cases Vs Total Deaths
-- Shows the chances of dying if you contract covid in your country
-- Change the like statement to look for country of choice
-- Some rows have no total_deaths inputted causing some % to be 0
Select location, STR_TO_DATE(date, '%m/%d/%Y') as Formatted_Date, total_cases, total_deaths, (total_deaths / total_cases ) * 100 as Death_Percentage
from covid_deaths_filtered
where location like '%states%'
order by STR_TO_DATE(date, '%m/%d/%Y') asc;

-- Looking at total cases Vs Population
-- Shows what percentage of population got covid
select location, STR_TO_DATE(date, '%m/%d/%Y') as Formatted_Date, total_cases, population, (total_cases / population) * 100 as Percentage_Infected
from covid_deaths_filtered
where location like '%states%'
order by STR_TO_DATE(date, '%m/%d/%Y') asc;


-- Looking at countries with highest infection rate agaisnt population
-- Top 15 countries with the highest infection rate
select location, MAX((total_cases / population)) * 100 as Percentage_Infected, population, max(total_cases) as HighestInfected
from covid_deaths_filtered
group by location, population
order by Percentage_Infected desc
limit 15;

-- Looking at countries with the lowest infection rate agaisnt population
-- Top 15 countries with the lowest infection rate
select location, MAX((total_cases / population)) * 100 as Percentage_Infected, population, max(total_cases) as HighestInfected
from covid_deaths_filtered
group by location, population
order by Percentage_Infected asc
limit 15;

-- Showing countries (not continent) with highest death count per population
-- 2 versions of this query, first with total deaths, second with total death agaisnt cases
select location, max(cast(total_deaths as unsigned)) as TotalDeaths
from covid_deaths_filtered
where continent != ''
group by location
order by TotalDeaths desc;

select 
	cd.location,
    cd.total_cases,
    d.MaxTotalDeaths as TotalDeaths
from
	covid_deaths_filtered cd
join (
	select 
		location, max(cast(total_deaths as unsigned)) as MaxTotalDeaths
	from 
		covid_deaths_filtered
	group by location
    ) d on cd.location = d.location AND cast(cd.total_deaths as unsigned) = d.MaxTotalDeaths
where continent != ''
order by
	TotalDeaths desc
limit 10;
		
-- Continet with the most deaths
select location, max(cast(total_deaths as unsigned)) as deaths
from covid_deaths_filtered
where continent=''
group by location
order by deaths desc;


-- 	GLOBAL NUMBERS

-- Total cases per day || did not include where contient because numbers would be invalid
select STR_TO_DATE(date, '%m/%d/%Y') as dated, sum(new_cases) as CasesPerDay, sum(new_deaths) as DeathsPerDay, round(sum(cast(new_deaths as decimal(10,6))) / sum(cast(new_cases as decimal(10,6))) * 100, 2) as PercentageDeath
from covid_deaths_filtered
where continent != ''
group by dated
order by 1,2;


-- Percentage of all world deaths given cases
select sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths , (sum(cast(new_deaths as decimal)) / sum(cast(new_cases as decimal))) * 100 as Percentage
from covid_deaths_filtered
where continent != '';

-- Utilizing Covid Vaccinations file now 
select *
from covid_deaths_filtered death
join covid_vaccines_filtered vacc
	on death.location = vacc.location
    and death.date = vacc.date
order by death.date desc;

-- Looking at total populations vs vaccinations
select death.continent, death.location, death.date, death.population, cast(vacc.new_vaccinations as unsigned) as NewVaccinations,
sum(cast(vacc.new_vaccinations as unsigned)) OVER (partition by death.location order by death.location, death.date) as RollingVaccinations,
(sum(cast(vacc.new_vaccinations as unsigned)) OVER (partition by death.location order by death.location, death.date))/ death.population * 100 as RollingPercentage
from covid_deaths_filtered death
	join covid_vaccines_filtered vacc
		on death.location = vacc.location
        and death.date = vacc.date
where death.continent !=''
order by 2,3;

-- Same previous query however utilizing a CTE for better readability

With PopOnVac (continent, location, date, population, new_vaccinations, RollingVaccinations)
as (
select death.continent, death.location, death.date, death.population, cast(vacc.new_vaccinations as unsigned) as NewVaccinations,
sum(cast(vacc.new_vaccinations as unsigned)) OVER (partition by death.location order by death.location, death.date) as RollingVaccinations
from covid_deaths_filtered death
	join covid_vaccines_filtered vacc
		on death.location = vacc.location
        and death.date = vacc.date
where death.continent !=''
)

select *, (RollingVaccinations/population) * 100
from PopOnVac

-- Need to create views future steps
