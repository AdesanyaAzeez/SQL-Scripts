/* Q13. Find actor’s first_name that starts with ‘P’ followed by 'e' or 'a' 
		then any other letter */
SELECT *
FROM actor
WHERE first_name SIMILAR TO 'P[a|e]%'