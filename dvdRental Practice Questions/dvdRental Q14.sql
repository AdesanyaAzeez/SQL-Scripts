-- Q14. Find actor’s first_name that starts with ‘P’ followed by any 5 letters

SELECT *
FROM actor
WHERE first_name LIKE 'P_____'