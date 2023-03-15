--Q10. What is the number of rented film for each rating?

SELECT f.rating, COUNT(sub.film_id) rented_film
FROM (
	SELECT i.film_id, r.rental_id
	FROM rental r JOIN inventory i
	On r.inventory_id = i.inventory_id
	)sub
JOIN film f ON sub.film_id = f.film_id
GROUP BY f.rating
ORDER BY 2 DESC

