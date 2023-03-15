--Q8. What is title of the most rented film?

SELECT f.title AS film_title
FROM (
	SELECT i.film_id, COUNT(r.rental_id) film_count
	FROM rental r JOIN inventory i
	ON r.inventory_id = i.inventory_id
	GROUP BY 1
	)sub
JOIN film f ON sub.film_id = f.film_id
ORDER BY film_count DESC
LIMIT 1
