--Q12. Count the number of actors whose first name doesn't start with "A"

SELECT COUNT(*) name_count
FROM actor
WHERE first_name NOT LIKE ('A%')