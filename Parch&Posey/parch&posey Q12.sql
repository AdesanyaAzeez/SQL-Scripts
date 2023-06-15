/* Q12. Find the mean (AVERAGE) amount spent per order on each paper type, as well as the 
	mean amount of each paper type purchased per order. Your final answer should have 6 values, 
	one for each paper type for the average number of sales, as well as the average amount.
*/

SELECT AVG(standard_qty) avg_standard_qty,
		AVG(poster_qty) avg_poster_qty,
		AVG(gloss_qty) avg_glossy_qty,
		AVG(standard_amt_usd) avg_standard_amt,
		AVG(poster_amt_usd) avg_poster_amt,
		AVG(gloss_amt_usd) avg_glossy_amt
FROM orders