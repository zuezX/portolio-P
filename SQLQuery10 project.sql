select*
from [portfolio project].dbo.CovidDeaths$
where location is not null
order by 3,4

--select*
--from [portfolio project].dbo.Covidvaccainiont
--order by 3,4

select location,date , total_cases, new_cases, total_deaths, population
from [portfolio project].dbo.CovidDeaths$
where location is not null
order by 1,2


--select location,date , total_cases,  total_deaths, (total_deaths/total_cases) * 100 as deathpeercention
--from [portfolio project].dbo.CovidDeaths$
--where location like '%somali%'
--where location is not null
--order by 1,2

select location,date , population, total_cases , (total_cases/population) * 100 as deathpeercention
from [portfolio project].dbo.CovidDeaths$
where location like '%somali%'
where location is not null
order by 1,2

select location , population ,MAX( total_cases ) as highestinfectioncount, max( (total_cases/population)) * 100 as percentionpopulatoininfected
from [portfolio project].dbo.CovidDeaths$
--where location like '%somali%'
group by  location , population 
order by percentionpopulatoininfected desc



select location ,max (cast(total_deaths as int))  as totaldeathcount
from [portfolio project].dbo.CovidDeaths$
--where location like '%somali%'
where continent is  null
group by location
order by totaldeathcount desc


select  SUM(new_cases) as totalcases, sum (cast(new_deaths as int)) as totaldeath, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Deathpercentage
from [portfolio project].dbo.CovidDeaths$
--where location like '%somali%'
where continent is not null
---group by date
order by 1,2


select dea.continent, dea.location,dea.date , population, vacc.new_vaccinations
, sum (convert( int,vacc.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as peoplevacc
--, (peoplevacc/population)*100
from [portfolio project].dbo.CovidDeaths$ dea
join  [portfolio project].dbo.Covidvaccainiont vacc
   on dea.location = vacc.location
   and dea.date=vacc.date
   where dea.continent is not null
   order by 1,2
  
  WITH peoplevaccvs Vacc, (continent, location , date ,population,vacc.new_vaccinations, peoplevacc)
  as 
   select dea.continent, dea.location,dea.date , population, vacc.new_vaccinations
, sum (convert( int,vacc.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as peoplevacc
--, (peoplevacc/population)*100
from [portfolio project].dbo.CovidDeaths$ dea
join  [portfolio project].dbo.Covidvaccainiont vacc
   on dea.location = vacc.location
   and dea.date=vacc.date
   where dea.continent is not null
   order by 1,2,3
   select * ,(peoplevacc/population )*100
   
   create view percentagepopulatiobvaccinated as

   select dea.continent, dea.location,dea.date , population, vacc.new_vaccinations
, sum (convert( int,vacc.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as peoplevacc
--, (peoplevacc/population)*100
from [portfolio project].dbo.CovidDeaths$ dea
join  [portfolio project].dbo.Covidvaccainiont vacc
   on dea.location = vacc.location
   and dea.date=vacc.date
   where dea.continent is not null
  -- order by 1,2
  select *
  from percentagepopulatiobvaccinated