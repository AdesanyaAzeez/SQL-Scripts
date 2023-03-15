-- Q3. Are there customers that share the same address?

SELECT t1.first_name, t2.last_name
FROM customer t1, customer t2 
WHERE t1.customer_id <> t2.customer_id
AND t1.address_id = t2.address_id