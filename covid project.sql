select * from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4 -- arranging accordint to the third column (location) followed by the 4th column (date)

--select * from PortfolioProject..CovidVaccinations
--order by 3,4

-- selecting data to be used
select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- looking at the total cases vs total deaths
-- shows the likelihood of dying if contacted by covid in a country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPerrcentage
from PortfolioProject..CovidDeaths
where location like '%nepal%'
order by 1,2

-- looking at the total cases vs the population
-- shows what % of population got covid
select location, date, total_cases, population, (total_cases/population)*100 as GotCovid
from PortfolioProject..CovidDeaths
where location like '%nepal%'
order by 1,2

-- looking at the countries with the highest infection rate compared to population
select location, max(total_cases) as HighestInfectionCount, population, max((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%nepal%'
group by location, population
order by PercentPopulationInfected desc

-- countries with the highest death count per population
select location, max(cast (total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

-- breaking things down by continent
-- showing the continents with the highest death counts
select continent, max(cast (total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

-- global numbers
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, (sum(cast(new_deaths as int))/sum(new_cases))*100 as deathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
--group by date
order by 1,2 

-- loooking at total population vs total vaccination
--using CTE (FIRSST METHOD)
with PopvsVac (continent, location, date, population,new_vaccinations, RollingPeopleVaccinated)
as(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum( cast (vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)

select *, (RollingPeopleVaccinated/population) *100 from PopvsVac

--temp table (alternative method)
create table #PercentPopulationVaccinated(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccination numeric,
RollingPeopleVaccinated numeric)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum( cast (vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
--order by 2,3
select *, (RollingPeopleVaccinated/population) *100 from #PercentPopulationVaccinated

-- creating view to store data for visualizations
create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum( cast (vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null

select * from PercentPopulationVaccinated