SLIDE 3 

NULLS & Aggregation examoples: 

SELECT *
FROM accounts
WHERE primary_poc = NULL

SELECT *
FROM accounts
WHERE primary_poc IS NOT NULL


SLIDE 4 

SELECT COUNT(*)
FROM accounts;

SELECT COUNT(accounts.id)
FROM accounts;


SLIDE 5 

SELECT COUNT(primary_poc) AS account_primary_poc_count
FROM accounts

SELECT *
FROM accounts
WHERE primary_poc IS NULL

SLIDE 6 

SELECT SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders

SLIDE 7 

1. Find the total amount of poster_qty paper ordered in the orders table.

SELECT SUM(poster_qty) FROM orders;
Output: 723646

2. Find the total amount of standard_qty paper ordered in the orders table.

SELECT SUM(standard_qty) FROM orders;
Output: 1938346

3. Find the total dollar amount of sales using the total_amt_usd in the orders table.

SELECT SUM(total_amt_usd) FROM orders;
Output: 23141511.83

4. Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

5. Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both aggregation and a mathematical operator.

SELECT SUM(standard_amt_usd)/ SUM(standard_qty) AS stand FROM orders;
Output: 4.9900000000000000

SLIDE 9

SELECT MIN(standard_qty) AS standard_min,
       MIN(gloss_qty) AS gloss_min,
       MIN(poster_qty) AS poster_min,
       MAX(standard_qty) AS standard_max,
       MAX(gloss_qty) AS gloss_max,
       MAX(poster_qty) AS poster_max
FROM   orders;
Output:

standard_min	gloss_min	poster_min	standard_max	gloss_max	poster_max
0	            0	        0	        22591	        14281	    28262

SLIDE 10 

SELECT AVG(standard_qty) AS standard_avg,
       AVG(gloss_qty) AS gloss_avg,
       AVG(poster_qty) AS poster_avg
FROM orders

Output: 

standard_avg	        gloss_avg	            poster_avg
280.4320023148148148	146.6685474537037037	104.6941550925925926