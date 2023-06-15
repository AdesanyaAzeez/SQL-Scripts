--Q11. When was the earliest order ever placed?


SELECT MIN(occurred_at)
FROM orders

/* Write a query to answer the question without using Aggregations

SELECT occurred_at
FROM orders
ORDER BY 1
LIMIT 1

*/