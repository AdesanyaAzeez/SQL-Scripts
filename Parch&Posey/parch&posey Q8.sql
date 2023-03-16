/* Q8. Write a query that displays the order date and gloss_qty data for all orders 
	where gloss_qty is between 24 and 29.
*/

SELECT occurred_at orderdate, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29