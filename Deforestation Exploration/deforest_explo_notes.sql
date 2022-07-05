
Deforestation Exploration
Joe Karl Magnussen 
Udacity SQL Nanodegree Notes:

-------------------------------------------------------------------
PART 1 - GLOBAL SITUATION
-------------------------------------------------------------------

Temporary Table:

CREATE VIEW forestation AS SELECT f.country_code AS country_code, f.country_name AS country_name, f.year, f.forest_area_sqkm AS forest_area_sq_km, l.total_area_sq_mi*2.59 AS land_area_sq_km, r.region, r.income_group, (f.forest_area_sqkm*100)/(l.total_area_sq_mi*2.59) AS per_forest_area_sqkm FROM forest_area f JOIN land_area l on f.country_code = l.country_code AND f.year = l.year JOIN regions r ON r.country_code = f.country_code;


a. What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record denoted as “World" in the region table.

       SELECT *
       FROM forestation 
       WHERE country_name = 'World' 
       AND year = 1990;

       OUTPUT: 41282694.9

b. What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.”

       SELECT *
       FROM forestation 
       WHERE country_name = 'World' 
       AND year = 2016;

       OUTPUT: 39958245.9

c. What was the change (in sq km) in the forest area of the world from 1990 to 2016?

       SELECT (SELECT forest_area_sq_km
       FROM forestation 
       WHERE country_name = 'World' 
       AND year = 1990) - (SELECT forest_area_sq_km
       FROM forestation 
       WHERE country_name = 'World' 
       AND year = 2016) AS difference;
      
       OUTPUT: 1324449

d. What was the percent change in forest area of the world between 1990 and 2016?

       SELECT (1-((SELECT forest_area_sq_km
       FROM forestation 
       WHERE country_name = 'World' 
       AND year = 2016) / (SELECT forest_area_sq_km
       FROM forestation 
       WHERE country_name = 'World' 
       AND year = 1990)))*100 AS percentage;

       OUTPUT: 3.20824258980245

e. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?

       SELECT * FROM forest_area WHERE forest_area_sqkm <= 1324449 AND year = 2016 ORDER BY forest_area_sqkm DESC LIMIT 1;

       OUTPUT: 1250590 - Australia

-------------------------------------------------------------------
PART 2 - REGIONAL OUTLOOK
-------------------------------------------------------------------

Answering these questions will help you add information into the template.
Use these questions as guides to write SQL queries.
Use the output from the query to answer these questions.

Create a table that shows the Regions and their percent forest area (sum of forest area divided by sum of land area) in 1990 and 2016. (Note that 1 sq mi = 2.59 sq km).
Based on the table you created, ...

a. What was the percent forest of the entire world in 2016? 

       SELECT (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 2016 ORDER BY perecent_forest DESC LIMIT 1;

       Output: 

       perecent_forest
       31.3441787357731

Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?

Which region had the HIGHEST percent forest in 2016?

       SELECT region, (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 2016 GROUP BY region ORDER BY perecent_forest DESC LIMIT 1;

       Output: 

       region	                     perecent_forest
       Latin America & Caribbean	46.1620721996047

and which had the LOWEST?

       Output: 

       SELECT region, (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 2016 GROUP BY region ORDER BY perecent_forest ASC LIMIT 1;

       region	                     perecent_forest
       Middle East & North Africa	2.06826486871501


b. What was the percent forest of the entire world in 1990? Which region had the HIGHEST percent forest in 1990, and which had the LOWEST, to 2 decimal places?

What was the percent forest of the entire world in 1990?

       SELECT (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 1990 ORDER BY perecent_forest DESC LIMIT 1;

       Output: 

       perecent_forest
       32.2111306265193

Which region had the HIGHEST percent forest in 1990?

       SELECT region, (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 1990 GROUP BY region ORDER BY perecent_forest DESC LIMIT 1;

       Output: 

       region	                     perecent_forest
       Latin America & Caribbean	51.0299798667514

and which had the LOWEST?

       SELECT region, (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 1990 GROUP BY region ORDER BY perecent_forest ASC LIMIT 1;

       region	                     perecent_forest
       Middle East & North Africa	1.77524062469353

c. Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?

       SELECT region, (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 2016 GROUP BY region ORDER BY perecent_forest DESC;

       AND 

       SELECT region, (SUM(forest_area_sq_km)/SUM(land_area_sq_km)*100) AS perecent_forest FROM forestation WHERE year = 1990 GROUP BY region ORDER BY perecent_forest DESC;

       Output/ Findings: 
       
       Latin America and Caribbean (dropped from 51.02% to 46.16%) and Sub-Saharan Africa (30.67% to 28.78%)

------------------------------------------------------------------
PART 3 - COUNTRY-LEVEL DETAIL
------------------------------------------------------------------


top % change from 1990 - 2016? 


       WITH forest_1990 AS (SELECT country_code, year, country_name, forest_area_sq_km 
       FROM forestation 
       WHERE year = 1990), 

       forest_2016 AS (SELECT country_code, year, country_name, forest_area_sq_km FROM forestation WHERE year = 2016)

       SELECT f16.country_code, f16.country_name, 
       f90.year AS year_1990, 
       f16.year AS year_2016,
       f90.forest_area_sq_km AS forest_1990, 
       f16.forest_area_sq_km AS forest_2016, (f16.forest_area_sq_km - f90.forest_area_sq_km) AS forest_area_disparity, (f16.forest_area_sq_km - f90.forest_area_sq_km)*100/(f90.forest_area_sq_km) AS per_change_in_forest_area

       FROM forest_1990 f90
       JOIN forest_2016 f16
       ON f90.country_code = f16.country_code
       AND f90.country_name = f16.country_name
       WHERE (f90.forest_area_sq_km IS NOT NULL) AND (f16.forest_area_sq_km  IS NOT NULL)
       AND (f16.country_name != 'world')
       ORDER BY per_change_in_forest_area DESC LIMIT 1;


       Output:

       country_code	country_name	forest_area_disparity	per_change_in_forest_area
       ISL	       Iceland	343.9999962	              213.664588870028


a. Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?

       WITH forest_1990 AS (SELECT country_code, year, country_name, forest_area_sq_km 
       FROM forestation 
       WHERE year = 1990), 

       forest_2016 AS (SELECT country_code, year, country_name, forest_area_sq_km FROM forestation WHERE year = 2016)

       SELECT f16.country_code, f16.country_name, 
       f90.year AS year_1990, 
       f16.year AS year_2016, 
       f90.forest_area_sq_km AS forest_1990, 
       f16.forest_area_sq_km AS forest_2016, (f16.forest_area_sq_km - f90.forest_area_sq_km) AS forest_area_disparity 

       FROM forest_1990 f90
       JOIN forest_2016 f16
       ON f90.country_code = f16.country_code
       AND f90.country_name = f16.country_name
       WHERE (f90.forest_area_sq_km IS NOT NULL) AND (f16.forest_area_sq_km  IS NOT NULL)
       AND (f16.country_name != 'world')
       ORDER BY forest_area_disparity DESC LIMIT 6

       Order BY land_area_sq_km and then forest_area_disparity DESC? 




b. Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? What was the percent change to 2 decimal places for each?


       WITH forest_1990 AS (SELECT country_code, year, country_name, forest_area_sq_km 
       FROM forestation 
       WHERE year = 1990), 

       forest_2016 AS (SELECT country_code, year, country_name, forest_area_sq_km FROM forestation WHERE year = 2016)

       SELECT f16.country_code, f16.country_name, 
       f90.year AS year_1990, 
       f16.year AS year_2016, 
       f90.forest_area_sq_km AS forest_1990, 
       f16.forest_area_sq_km AS forest_2016, (f16.forest_area_sq_km - f90.forest_area_sq_km) AS forest_area_disparity, (f16.forest_area_sq_km - f90.forest_area_sq_km)*100/(f90.forest_area_sq_km) AS per_change_in_forest_area

       FROM forest_1990 f90
       JOIN forest_2016 f16
       ON f90.country_code = f16.country_code
       AND f90.country_name = f16.country_name
       WHERE (f90.forest_area_sq_km IS NOT NULL) AND (f16.forest_area_sq_km  IS NOT NULL)
       AND (f16.country_name != 'world')
       ORDER BY per_change_in_forest_area ASC LIMIT 6;

c. If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?

SELECT DISTINCT(forestation_quartiles), 
COUNT(country_name)
OVER (PARTITION BY forestation_quartiles)
FROM (SELECT country_name,
CASE WHEN per_forest_area_sqkm <= 25
THEN 1 WHEN per_forest_area_sqkm > 25
AND per_forest_area_sqkm <= 50 
THEN 2 WHEN per_forest_area_sqkm > 50 
AND per_forest_area_sqkm <= 75 THEN 3 
ELSE 4 END AS forestation_quartiles
FROM forestation
WHERE year = 2016 
AND (per_forest_area_sqkm IS NOT NULL)) fq

Output:

forestation_quartiles	count
1	                     85
2	                     73
3	                     38
4	                     9


d. List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016.

SELECT region, ROUND(per_forest_area_sqkm::numeric, 2) AS rounded, country_name
FROM forestation WHERE year = 2016 
AND (per_forest_area_sqkm > 75) 
ORDER BY rounded DESC;
