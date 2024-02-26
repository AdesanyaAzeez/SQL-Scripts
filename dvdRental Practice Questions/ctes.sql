-- Q1. Display each movie title and the number of times it got rented.
WITH cte AS
(
SELECT i.film_id, COUNT(r.rental_id) rental_count
FROM rental r JOIN inventory i
  ON r.inventory_id = i.inventory_id
GROUP BY 1
)
SELECT f.title AS film_title, 
        c.rental_count
FROM film f 
JOIN cte c
  ON f.film_id = c.film_id
ORDER BY 2 DESC


-- Q2. Which customer rented a film more than once?
WITH cte AS 
(
SELECT r.customer_id, r.rental_date::DATE AS rental_date, i.film_id
FROM rental r JOIN inventory i
ON r.inventory_id = i.inventory_id
)
SELECT DISTINCT(t1.customer_id)
FROM cte t1, cte t2
--Check for customers and  film id with different rental_dates
WHERE t1.customer_id = t2.customer_id
AND t1.film_id = t2.film_id
AND t1.rental_date <> t2.rental_date
