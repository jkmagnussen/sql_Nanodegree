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

SLIDE 11 

1. When was the earliest order ever placed? You only need to return the date.

SELECT * FROM orders ORDER BY occurred_at LIMIT 1;
Output: Output: 2013-12-04T04:22:44.000Z

or

select MIN(occurred_at) FROM orders;
Output: 2013-12-04T04:22:44.000Z

2. Try performing the same query as in question 1 without using an aggregation function.

SELECT * FROM orders ORDER BY occurred_at LIMIT 1;
Output: 2013-12-04T04:22:44.000Z

3. When did the most recent (latest) web_event occur?

SELECT MAX(occurred_at) FROM web_events;
Output: 2017-01-01T23:51:09.000Z

4. Try to perform the result of the previous query without using an aggregation function.

SELECT occurred_at FROM web_events ORDER BY occurred_at DESC LIMIT 1;
Output: 2017-01-01T23:51:09.000Z

5. Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
        AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
        AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

6. Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?

SELECT *
FROM (SELECT total_amt_usd
   FROM orders
   ORDER BY total_amt_usd
   LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

SLIDE 13

SELECT account_id,
       SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders

Output: Error 


SELECT account_id,
       SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders
GROUP BY account_id
ORDER BY account_id

Output: 

account_id	standard	gloss	poster
1001	    7896	    7831	3197

SLIDE 14

1. Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.



Answer: 

SELECT o.occurred_at, name FROM orders o
LEFT JOIN accounts a ON o.account_id = a.id ORDER BY occurred_at ASC LIMIT 1;

Output: 

occurred_at	                name
2013-12-04T04:22:44.000Z	DISH Network

2. Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

Answer: 

SELECT a.name, SUM(o.total_amt_usd) 
FROM orders o 
LEFT JOIN accounts a 
ON o.account_id = a.id 
GROUP BY a.name;


3. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

Answer: 

SELECT we.occurred_at, we.account_id, we.channel, a.name 
FROM web_events we
LEFT JOIN accounts a 
ON we.account_id = a.id 
ORDER BY we.occurred_at DESC 
LIMIT 1;

Output: 

occurred_at	                account_id	channel	    name
2017-01-01T23:51:09.000Z	3001	    organic	    Molina Healthcare


4. Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

Answer: 

SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel

5. Who was the primary contact associated with the earliest web_event?

Answer: 

SELECT we.occurred_at, a.primary_poc 
FROM web_events we 
LEFT JOIN accounts a 
ON a.id = we.account_id 
ORDER BY we.occurred_at 
LIMIT 1;

Output: 

occurred_at	                primary_poc
2013-12-04T04:18:29.000Z	Leana Hawker

6. What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

Answer: 

SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

7. Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from the fewest reps to most reps.

Answer: 

SELECT r.name, SUM(sr.region_id) 
FROM region r
LEFT JOIN sales_reps sr 
ON sr.region_id = r.id 
GROUP BY r.id;


SLIDE 16

SELECT account_id,
       channel,
       COUNT(id) as events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, channel DESC

SLIDE 17

1. For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

Answer: 

SELECT a.name AS name, AVG(standard_qty) AS average_standard, 
AVG(gloss_qty) AS average_gloss, 
AVG(poster_qty) AS average_poster
FROM orders o
JOIN accounts a ON o.account_id = a.id 
GROUP BY name
ORDER BY name;

2. For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

Answer: 

SELECT a.name AS name, AVG(standard_amt_usd) AS average_standard, 
AVG(gloss_amt_usd) AS average_gloss, 
AVG(poster_amt_usd) AS average_poster
FROM orders o
JOIN accounts a ON o.account_id = a.id 
GROUP BY name
ORDER BY name;


3. Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

Answer: 

SELECT sr.name, we.channel, COUNT(*) num_events 
FROM accounts a 
JOIN web_events we
ON we.account_id = a.id 
JOIN sales_reps sr 
ON a.sales_rep_id = sr.id
GROUP BY sr.name, we.channel
ORDER BY num_events DESC;


4. Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

Answer: 

SELECT 

SELECT r.name, we.channel, COUNT(*) num_events 
FROM accounts a 
JOIN web_events we
ON we.account_id = a.id 
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r 
ON sr.region_id = r.id
GROUP BY r.name, we.channel
ORDER BY num_events DESC;

SLIDE 19 

SELECT account_id,
       channel,
       COUNT(id) as events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, channel DESC


SELECT DISTINCT account_id,
       channel
FROM web_events
ORDER BY account_id


SLIDE 20 

1. Use DISTINCT to test if there are any accounts associated with more than one region.

SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

and 

SELECT DISTINCT id, name
FROM accounts;

2. Have any sales reps worked on more than one account?

Actually, all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query.

Answer:

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

and 

SELECT DISTINCT id, name
FROM sales_reps;


SLIDE 22 

SELECT account_id,
       SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
GROUP BY 1
ORDER BY 2 DESC


SELECT account_id,
       SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
GROUP BY 1
HAVING SUM(total_amt_usd) >= 250000


slide 23 

WHERE subsets the returned data based on a logical condition.

WHERE appears after the FROM, JOIN, and ON clauses, but before GROUP BY.

HAVING appears after the GROUP BY clause, but before the ORDER BY clause.

HAVING is like WHERE, but it works on logical statements involving aggregations.


1. How many of the sales reps have more than 5 accounts that they manage?

Answer: 

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

2. How many accounts have more than 20 orders?

Answer: 

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

3. Which account has the most orders?

Answer: 

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

4. Which accounts spent more than 30,000 usd total across all orders?

Answer: 

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;