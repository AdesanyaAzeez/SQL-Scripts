--Q11. Show the profit of Store 1 and 2?

SELECT i.store_id, SUM(p.amount) Total_amount
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY 1