-- Q15. Find actors with 'PaRkEr' as their first_name and ignore the letter case.

SELECT *
FROM actor
WHERE first_name ILIKE 'PaRkEr'