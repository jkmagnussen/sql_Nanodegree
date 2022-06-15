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

SELECT a.sales_rep_id
FROM accounts a
JOIN region 
ON a.sales_rep_id = 