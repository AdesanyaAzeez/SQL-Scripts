-- Q10. Find the standard_amt_usd per unit of standard_qty paper.

SELECT ROUND(SUM(standard_amt_usd)/ SUM(standard_qty),2) unitprice
FROM orders