--Select *
--From PProject..CovidDeaths
--Where continent is not null
--order by 3,4

--Select *
--From PProject..CovidVaccinations
--order by 3,4

--Select Location, date, total_cases, new_cases, total_deaths, population
--From PProject..CovidDeaths
--order by 1,2

--total cases vs total deaths

--Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From PProject..CovidDeaths
--Where location like '%india%'
--order by 1,2

-- looking at total case vs population

--Select Location, date, total_cases, Population, (total_cases/population)*100 as Percentage
--From PProject..CovidDeaths
--Where location like '%india%'
--order by 1,2

--country with highest infection rate

--Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePOPINFECTED
--From PProject..CovidDeaths
----Where location like '%india%'
--Group by location, Population
--order by PercentagePOPINFECTED desc

-- Showing Countries with Highest Death Count Population

--Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
--From PProject..CovidDeaths
--Where continent is null
--Group by location
--order by TotalDeathCount desc

--continent w highest death count

--Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
--From PProject..CovidDeaths
--Where continent is not null
--Group by continent
--order by TotalDeathCount desc

-- gloab no.s
Select date, SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))/Sum(New_cases)*100 as DeathPercentage
From PProject..CovidDeaths
Where continent is not null
Group by date
order by 1,2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PProject..CovidDeaths dea
Join PProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3


-- Using CTE to perform Calculation on Partition By in previous query

; With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PProject..CovidDeaths dea
Join PProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PProject..CovidDeaths dea
Join PProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated




-- Creating View to store data for later visualizations
DROP VIEW IF EXISTS PercentPopulationVaccinated;
GO

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PProject..CovidDeaths dea
Join PProject..CovidVaccinations vac
    On dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null

