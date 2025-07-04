# 📊 COVID-19 Data Exploration and Visualization
This project explores global COVID-19 data using SQL Server and presents insights via Tableau Public dashboards. The dataset includes infection rates, death counts, population statistics, and vaccination trends.

# 📁 Dataset Information
The data used in this project was sourced from Our World in Data, available at:
🔗 https://ourworldindata.org/covid-deaths

The used data in this project ranges from : June 2020 to March 2021

The dataset provides global COVID-19 statistics, updated regularly and compiled from official public health sources. For this analysis, the data was divided into two main tables:

1. CovidDeaths: Contains information such as location, date, total cases, new cases, total deaths, population, and continent.

2. CovidVaccinations: Includes columns for daily and cumulative vaccinations, vaccine types, and other immunization statistics.

## 🔍 SQL Analysis Overview
1. The SQL queries in this project cover: Basic filtering and sorting of COVID-19 cases and deaths

2. Comparative analysis:
   - Total Cases vs Total Deaths (to compute mortality rate)
   - Total Cases vs Population (to calculate infection percentage)

3. Identifying high-impact countries:
   - Countries with the highest infection or death rates
   - Continent-wise breakdown of total deaths

4. Rolling vaccination tracking using:
   - CTEs (Common Table Expressions)
   - Temporary tables

5. View creation for reusable queries: Queries used in Tableau visualizations to power key dashboard metrics

## 📈 Tableau Dashboard
A Tableau Public dashboard was created based on the above queries, featuring:

- Global COVID statistics
- Top countries by death count
- Infection percentages by population
- Daily trends over time

**🔗 View the live dashboard here:** https://public.tableau.com/app/profile/aavash.shrestha/viz/CovidDashboard_17513814514670/Dashboard1?publish=yes
