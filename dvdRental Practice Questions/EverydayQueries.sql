-- Q1. How many customers have made payment for a film?
SELECT COUNT(DISTINCT(customer_id))
FROM payment


-- Q2. What is the total amount paid by each customer?
SELECT customer_id,  
      SUM(amount) total_amount
FROM payment
GROUP BY 1
ORDER BY SUM(amount) DESC


/* Q3. Find actor’s first_name that starts with ‘P’ followed by 'e' or 'a' 
		then any other letter */
SELECT *
FROM actor
WHERE first_name SIMILAR TO 'P[a|e]%'

  
-- Q4. What is the total amount paid by each customer?
SELECT customer_id,  
      SUM(amount) total_amount
FROM payment
GROUP BY 1
ORDER BY SUM(amount) DESC


--Q5. Show the profit of Store 1 and 2?
SELECT i.store_id, 
      SUM(p.amount) Total_amount
FROM payment p
JOIN rental r 
  ON p.rental_id = r.rental_id
JOIN inventory i 
  ON r.inventory_id = i.inventory_id
GROUP BY 1


-- Q6. Find actor’s first_name that starts with ‘P’ followed by any 5 letters
SELECT *
FROM actor
WHERE first_name LIKE 'P_____'


--Q7. Are there actors who share the same name? Write a query to show the name(s) of the actors 
SELECT t1.actor_id, 
      CONCAT(t1.first_name,' ',t1.last_name) full_name
FROM actor t1 JOIN actor t2
  ON t1.actor_id <> t2.actor_id
WHERE CONCAT(t1.first_name,' ',t1.last_name) = CONCAT(t2.first_name,' ',t2.last_name)

-- Q8. Find actors with 'PaRkEr' as their first_name and ignore the letter case.
SELECT *
FROM actor
WHERE first_name ILIKE 'PaRkEr'
