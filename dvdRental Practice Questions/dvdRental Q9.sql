--Q9. Which customer rented a film more than once?

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



