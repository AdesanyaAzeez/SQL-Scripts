--Q4. How many films has each actor acted in?

SELECT first_name||' '||last_name AS actor_name, film_count
FROM (
	SELECT actor_id, COUNT(film_id) film_count
	FROM film_actor
	GROUP BY 1
	)sub
JOIN actor a
ON sub.actor_id = a.actor_id
ORDER BY 2 DESC