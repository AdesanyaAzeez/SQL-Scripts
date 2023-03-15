--Q6. Display each movie title and the number of times it got rented.

WITH cte AS
(
SELECT i.film_id, COUNT(r.rental_id) rental_count
FROM rental r JOIN inventory i
ON r.inventory_id = i.inventory_id
GROUP BY 1
)
SELECT f.title AS film_title, c.rental_count
FROM film f JOIN cte c
ON f.film_id = c.film_id
ORDER BY 2 DESC