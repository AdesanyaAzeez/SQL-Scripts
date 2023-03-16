/* Q6. Use the web_events table to find all information regarding individuals who were contacted 
	via any channel except using organic or adwords.
*/

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')