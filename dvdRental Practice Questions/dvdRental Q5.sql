--Q5. Are there actors who share the same name? Write a query to show the name(s) of the actors 

SELECT t1.actor_id, CONCAT(t1.first_name,' ',t1.last_name) full_name
FROM actor t1 JOIN actor t2
ON t1.actor_id <> t2.actor_id
WHERE CONCAT(t1.first_name,' ',t1.last_name) = CONCAT(t2.first_name,' ',t2.last_name)
