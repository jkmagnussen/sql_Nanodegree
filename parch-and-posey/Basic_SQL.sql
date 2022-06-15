Basic SQL

Solutions to ORDER BY questions


1. Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

2. Write a query to return the top 5 orders in terms of the largest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;


3. Write a query to return the lowest 20 orders in terms of the smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;



We can ORDER BY more than one column at a time. When you provide a list of columns in an ORDER BY command, the sorting occurs using the leftmost column in your list first, then the next column from the left, and so on. We still have the ability to flip the way we order using DESC.

Code from the Video
SELECT  account_id,
        total_amt_usd
FROM orders
ORDER By total_amt_usd DESC, account_id
This query selected account_id and total_amt_usd from the orders table, and orders the results first by total_amt_usd in descending order and then account_id.

SLIDE 22 Q&As: 

Question:

1. Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).

answer: 

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

Question:

2. Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).

answer: 

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;


SLIDE 24 - WHERE CONDITION EXAMPLE:

SELECT *
FROM orders
WHERE account_id = 4251
ORDER BY occurred_at
LIMIT 1000;

question:

Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

answer:SELECT * FROM orders WHERE gloss_amt_usd >= 1000 LIMIT 5;

question: 

Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

answer: SELECT * FROM orders WHERE total_amt_usd < 500 LIMIT 10;

SLIDE 28 

question: 

Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.

answer: SELECT name, website, primary_poc FROM accounts WHERE name = 'Exxon Mobil';

Slide 30 QUESTION: 

Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

Answer: SELECT id, account_id, standard_amt_usd/ standard_qty AS unit_price FROM orders LIMIT 10;

SLIDE 35 QUESTIONS: 

1. Use the accounts table to find ll the companies whose names start with 'C'.

Answer: SELECT * FROM accounts WHERE name LIKE 'C%';

2. All companies whose names contain the string 'one' somewhere in the name.

answer: SELECT * FROM accounts WHERE name LIKE '%one%';

3. All companies whose names end with 's': 

answer: SELECT * FROM accounts WHERE name LIKE '%s';

SLIDE 38: 

1. Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.

answer: SELECT name, primary_poc, sales_rep_id FROM accounts WHERE name IN ('Walmart', 'Target', 'Nordstrom');

2. Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

ANSWER: SELECT * FROM web_events WHERE channel IN ('organic','adwords');

SLIDE 41: 

1. Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.

Answer: SELECT name, primary_poc, sales_rep_id 
FROM accounts 
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

2. Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.

Answer: SELECT * FROM web_events 
WHERE channel NOT IN ('organic', 'adwords');

SLIDE 43 EXAMPLES:

SELECT *
FROM orders
WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
ORDER BY occurred_at


SELECT *
FROM orders
WHERE occurred_at BETWEEN '2016-04-01' AND '2016-10-01'
ORDER BY occurred_at

SLIDE 44: 

1. Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.

Answer: SELECT * FROM orders WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

2. Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.

Answer: SELECT name FROM accounts WHERE name != 'C%' AND name LIKE '%s';

3. When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.

Answer: Yes it includes endpoints, logic - SELECT occurred_at, gloss_qty FROM orders WHERE gloss_qty BETWEEN 24 and 49 ORDER BY gloss_qty;

4. Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.

Answer: 

ANSWER: SELECT * FROM web_events WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01 00:00:00' AND '2017-01-01 00:00:00' ORDER BY occurred_at DESC;

SLIDE 46

SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE (standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0)
AND occurred_at = '2016-10-01'

SLIDE 47

1. Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.

Answer: SELECT id FROM orders WHERE (gloss_qty > 4000 OR poster_qty > 4000);

2. Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.

Answer: SELECT * FROM orders 
WHERE standard_qty = 0
AND (gloss_qty > 1000 OR poster_qty > 1000);

3. Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.

Answer: 

SELECT * FROM accounts 
WHERE (name LIKE 'C%' OR name LIKE 'W%')
       AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
       AND primary_poc NOT LIKE '%eana%';