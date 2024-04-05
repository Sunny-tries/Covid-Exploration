# COVID-19 Data Analysis Project

## Overview

This project involves the analysis of COVID-19 data to uncover insights related to infection rates, death rates, and vaccination efforts across different countries and continents. Utilizing two primary CSV data sources, `covid_deaths_filtered` and `covid_vaccines_filtered`, the project meticulously cleans and transforms the data to ensure usability for complex queries.

## Data Preparation

The initial step involved cleaning the datasets to rectify inconsistencies, remove irrelevant entries, and ensure data integrity. This process was crucial for preparing the data for detailed analysis. Specific attention was given to standardizing date formats, ensuring numeric fields were correctly formatted, and handling missing or null values appropriately.

## Analysis Methods

The project employs a series of SQL queries to explore various aspects of the COVID-19 pandemic, including:

- **Total Cases vs. Total Deaths:** This analysis provides insights into the fatality rate of COVID-19 in different countries, revealing the likelihood of death upon contracting the virus.
- **Infection Rates:** By comparing the total cases to the overall population, this query highlights the percentage of the population affected by COVID-19 in different locations.
- **Highest and Lowest Infection Rates:** Identifying countries with the highest and lowest infection rates against their population sizes offers a global perspective on the pandemic's impact.
- **Vaccination Analysis:** The project examines vaccination efforts, tracking the rollout of vaccinations and calculating the percentage of populations vaccinated over time.

### Key Queries

1. **Global Numbers:** Aggregating global case and death numbers to understand daily and overall trends.
2. **Continent and Country-Specific Analysis:** Looking into how different continents and countries have been affected by and responded to the pandemic.
3. **Vaccination Efforts:** Examining the progress of vaccination campaigns, including new vaccinations and cumulative vaccinations over time.

## Technologies Used

- **SQL:** The primary tool for data manipulation, analysis, and querying.
- **CSV Files:** `covid_deaths_filtered` and `covid_vaccines_filtered` served as the main data sources.

## Project Highlights

- **Data Cleaning and Transformation:** The project emphasizes preparing the data for analysis, ensuring accuracy in the insights generated.
- **Comprehensive Analysis:** Through a variety of queries, the project covers multiple facets of the pandemic, from infection rates to vaccination efforts.
- **Adaptability:** The use of SQL allows for flexible, in-depth analysis, accommodating future data updates and additional queries.

## Future Steps

- **Creating Views:** For more efficient data handling and analysis, creating views will organize frequently used queries and datasets.

## Visualizations
[https://public.tableau.com/app/profile/sunny.hardyal/viz/Covid-Exploration/Dashboard1?publish=yes]
