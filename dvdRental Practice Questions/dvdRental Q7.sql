--Q7. How many movies are not yet offered for rent in stores 1 and 2?

SELECT COUNT(film_id)
FROM film
WHERE film_id NOT IN
	(
	SELECT DISTINCT(film_id)
	FROM rental r 
	JOIN inventory i ON r.inventory_id = i.Inventory_id
	WHERE store_id = 1 OR store_id = 2
	)