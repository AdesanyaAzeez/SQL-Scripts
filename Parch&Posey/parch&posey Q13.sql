/* Q13. From the orders table, display the orderId, accountId and order_date. Along side these,
        show the 3 types of paper, the amount of papers ordered and their respective amount
		in a single separate column.
*/ 

SELECT id order_id, 
		account_id, 
		occurred_at::DATE AS order_date, 
		UNNEST(array['standard_qty', 'gloss_qty','poster_qty']) AS Paper_type,
		UNNEST(array[standard_qty, gloss_qty, poster_qty]) AS UnitsOrdered, 
		UNNEST(array[standard_amt_usd,gloss_amt_usd, poster_amt_usd]) AS Total_Amount
FROM orders;

