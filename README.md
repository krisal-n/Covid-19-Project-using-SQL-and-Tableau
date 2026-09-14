# Covid-19-Project-using-SQL-and-Tableau
SQL data exploration and Tableau dashboard analysing COVID-19 cases, deaths, and vaccination trends
# COVID-19 Data Analysis: SQL Exploration & Tableau Dashboard

## Overview
A short 2-3 sentence summary: what question you're answering (e.g., "Explores global COVID-19 
case, death, and vaccination trends to identify infection/mortality patterns across countries 
and time") and what tools you used (SQL for cleaning/analysis, Tableau for visualisation).

## Dashboard
[https://public.tableau.com/app/profile/krisal.naidu/viz/CovidDashboard_17891229114810/Dashboard1?publish=yes]
*Click the image above to view the interactive dashboard on Tableau Public.*

## Dataset
- Source: [https://ourworldindata.org/covid-deaths]
- Description: what it contains (case counts, deaths, vaccinations, by country/date)
- Files: located in `/dataset`

## Tools Used
- SQL Server / SSMS — data cleaning and exploratory analysis
- Tableau Public — dashboard and visualisation

## What I Did
- Cleaned and structured raw COVID-19 case/death/vaccination data
- Wrote SQL queries to calculate infection rate, death percentage, and vaccination 
  rate by country and over time
- Used window functions (e.g. rolling totals, partitions) to track cumulative 
  vaccination progress
- Built an interactive Tableau dashboard to visualise trends by country and time period.

## Files in This Repo
- `dataset/` — raw COVID-19 data (deaths, vaccinations).
-  `sql for tableau` — main results used for dashboard.
- `covid sql data exploration.sql` — full SQL cleaning and analysis script.
- `dashboard.png` — dashboard preview image.
- `README.md` — this file.
