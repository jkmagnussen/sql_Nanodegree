
Deforestation Exploration
Joe Karl Magnussen 
Udacity SQL Nanodegree Notes:

a. What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record denoted as “World" in the region table.

-------------------------------------------------------------------
PART 1 - GLOBAL SITUATION
-------------------------------------------------------------------

a. What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record denoted as “World" in the region table.

       SELECT SUM(forest_area_sqkm) AS total_area FROM forest_area WHERE year = 1990;

       OUTPUT: 82016472.036028

b. What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.”

       SELECT SUM(forest_area_sqkm) AS total_area FROM forest_area WHERE year = 2016;

       OUTPUT: 79825433.9505107

c. What was the change (in sq km) in the forest area of the world from 1990 to 2016?

       SELECT (SELECT SUM(forest_area_sqkm) FROM forest_area WHERE year = 1990) - (SELECT SUM(forest_area_sqkm) FROM forest_area WHERE year = 2016) AS difference;
      
       OUTPUT: 2191038.08551738

d. What was the percent change in forest area of the world between 1990 and 2016?

       SELECT (1-((SELECT SUM(forest_area_sqkm) FROM forest_area WHERE year = 2016) / (SELECT SUM(forest_area_sqkm) FROM forest_area WHERE year = 1990)))*100 AS percentage;

       OUTPUT: 2.67146102621301

e. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?

       SELECT * FROM forest_area WHERE forest_area_sqkm <= 2191038.08551738 AND year = 2016 ORDER BY forest_area_sqkm DESC LIMIT 1;

       OUTPUT: 2098635 - China

-------------------------------------------------------------------
PART 2 - REGIONAL OUTLOOK
-------------------------------------------------------------------

Answering these questions will help you add information into the template.
Use these questions as guides to write SQL queries.
Use the output from the query to answer these questions.

Create a table that shows the Regions and their percent forest area (sum of forest area divided by sum of land area) in 1990 and 2016. (Note that 1 sq mi = 2.59 sq km).
Based on the table you created, ....

a. What was the percent forest of the entire world in 2016? Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?

b. What was the percent forest of the entire world in 1990? Which region had the HIGHEST percent forest in 1990, and which had the LOWEST, to 2 decimal places?

c. Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?