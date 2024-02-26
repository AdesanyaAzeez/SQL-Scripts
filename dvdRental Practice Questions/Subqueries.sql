--Q1. How many films has each actor acted in?
SELECT first_name||' '||last_name AS actor_name, 
        film_count
FROM (
	SELECT actor_id, COUNT(film_id) film_count
	FROM film_actor
	GROUP BY 1
	)sub
JOIN actor a
ON sub.actor_id = a.actor_id
ORDER BY 2 DESC

  
--Q2. How many movies are not yet offered for rent in stores 1 and 2?
SELECT COUNT(film_id)
FROM film
WHERE film_id NOT IN
	(
	SELECT DISTINCT(film_id)
	FROM rental r 
	JOIN inventory i 
    ON r.inventory_id = i.Inventory_id
	WHERE store_id = 1 OR store_id = 2
	)


--Q3. What is title of the most rented film?
SELECT f.title AS film_title
FROM (
	SELECT i.film_id, COUNT(r.rental_id) film_count
	FROM rental r JOIN inventory i
	  ON r.inventory_id = i.inventory_id
	GROUP BY 1
	)sub
JOIN film f 
  ON sub.film_id = f.film_id
ORDER BY film_count DESC
LIMIT 1


--Q4. What is the number of rented film for each rating?
SELECT f.rating, COUNT(sub.film_id) rented_film
FROM (
	SELECT i.film_id, r.rental_id
	FROM rental r JOIN inventory i
	  ON r.inventory_id = i.inventory_id
	)sub
JOIN film f
  ON sub.film_id = f.film_id
GROUP BY f.rating
ORDER BY 2 DESC
