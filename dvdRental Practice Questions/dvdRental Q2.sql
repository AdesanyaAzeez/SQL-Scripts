-- Q2. What is the total amount paid by each customer?

SELECT customer_id,  SUM(amount) total_amount
FROM payment
GROUP BY 1
ORDER BY SUM(amount) DESC