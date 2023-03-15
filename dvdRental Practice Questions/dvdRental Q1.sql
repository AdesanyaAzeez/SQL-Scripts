-- Q1. How many customers have made payment for a film?

SELECT COUNT(DISTINCT(customer_id))
FROM payment