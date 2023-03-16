/* Q2. Write a query to return the top 5 orders in terms of largest total_amt_usd. 
	Include the id, account_id, and total_amt_usd. */

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY 3 DESC 
LIMIT 5