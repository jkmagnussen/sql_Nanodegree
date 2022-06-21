SQL Joins

SELECT orders.*,
       accounts.*
FROM orders 
JOIN accounts
ON orders.account_id = accounts.id;


For example, if we want to pull only the account name and the dates in which that account placed an order, but none of the other columns, we can do this with the following query:

SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

This query only pulls two columns, not all the information in these two tables. Alternatively, the below query pulls all the columns from both the accounts and orders table.

SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

And the first query you ran pull all the information from only the orders table:

SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SLIDE 5 

1. Try pulling all the data from the accounts table, and all the data from the orders table.

Answer: SELECT orders.*, accounts.* FROM orders JOIN accounts ON orders.account_id = accounts.id;

2. Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.

Answer: 
SELECT orders.standard_qty, orders.gloss_qty,
 orders.poster_qty, accounts.website,
 accounts.primary_poc
FROM orders 
JOIN accounts 
ON orders.account_id = accounts.id;

SLIDE 9 

JOIN More than Two Tables

SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id

SLIDE 10 

While aliasing tables is the most common use case. It can also be used to alias the columns selected to have the resulting table reflect a more readable name.

Example:

Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2

code from video - 

SELECT o.*, a.*
FROM orders o
JOIN accounts a
ON o.account_id = a.id

SLIDE 11 

1. Provide a table for all web_events associated with the account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

Answer: 

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

2.Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

Answer: 

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a 
ON s.id = a.sales_rep_id
ORDER BY a.name;

3. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

Answer: 

SELECT r.name region, a.name account, 
    o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

-------------------------------------------------------

NOTES ON THE SYNTAX OF LEFT JOINS 

SELECT *
FROM customers
LEFT JOIN orders 
ON customers.id = orders.customer_id
ORDER BY customers.id;

Let’s go through the syntax of LEFT JOIN:

SELECT – Start by listing the columns (from both tables) that you want to see in the result set (here we select all columns using *);
FROM – Put the name of the left table, the one where you want to keep all the records (i.e. customers);
LEFT JOIN – Write the name of the second (right) table (i.e. orders);
ON – Use this keyword to indicate the columns that will be used to join the tables, i.e. the ones with the matching values. (Here, it’s id from customers and customer_id from orders).

-------------------------------------------------------
SLIDE 18 

SELECT orders.*, accounts.*
FROM orders
LEFT JOIN accounts
ON orders.account_id = accounts.id 
WHERE accounts.sales_rep_id = 321500

Adding AND instead of WHERE makes the end condition an extension of the ON
clause instead of being an added filter on the end. 

SELECT orders.*, accounts.*
FROM orders
LEFT JOIN accounts
ON orders.account_id = accounts.id 
AND accounts.sales_rep_id = 321500

SLIDE 19 

1. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

Answer: 

SELECT r.name AS region_name, 
s.name AS sales_reps_name, 
a.name AS account_name
FROM sales_reps s
LEFT JOIN region r
ON s.region_id = r.id
LEFT JOIN accounts a
ON a.sales_rep_id = s.id 
WHERE r.name = 'Midwest'
ORDER BY a.name;


2.Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

Answer: 

SELECT r.name AS region_name, 
s.name AS sales_reps_name, 
a.name AS account_name
FROM sales_reps s
LEFT JOIN region r
ON s.region_id = r.id
LEFT JOIN accounts a
ON a.sales_rep_id = s.id 
WHERE s.name LIKE 'S%'
AND r.name = 'Midwest'
ORDER BY a.name;

3. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

Answer: 

SELECT r.name AS region_name, 
s.name AS sales_reps_name, 
a.name AS account_name
FROM sales_reps s
LEFT JOIN region r
ON s.region_id = r.id
LEFT JOIN accounts a
ON a.sales_rep_id = s.id 
WHERE STRING_SPLIT(s.name, '') LIKE 'K%'
AND r.name = 'Midwest'
ORDER BY a.name;

4. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

Answer: 

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;


5. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

Answer: 

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100
AND o.poster_qty > 50 
ORDER BY unit_price;


6. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

Answer: 

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100
AND o.poster_qty > 50 
ORDER BY unit_price DESC;


7. What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.

Answer: 

SELECT a.name, we.channel
FROM accounts a
LEFT JOIN web_events we
ON we.account_id = a.id
WHERE a.id = 1001;

8. Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.

Answer: 

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o 
JOIN accounts a
ON o.account_id = a.id
WHERE o.occured_at BETWEEN '2015-01-01' AND '2015-12-31';