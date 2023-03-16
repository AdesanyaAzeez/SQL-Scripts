/* Q5. Filter the accounts table to include the company name, website, and the primary point of 
		contact (primary_poc) just for the Exxon Mobil company in the accounts table.
*/

SELECT name company_name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'