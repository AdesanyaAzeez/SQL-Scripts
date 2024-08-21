## Sales & Inventory Management with Stored Procedures in SQL

This folders holds stored procedure scripts that does the foolowing
- populates sales table based on orders,
- notifies if an ordered unit is more than the available stock,
- updates product details if any (price and quantity)
- add new product to the product table making sure there's no product id and product name mismatch/duplicates
- keep record of all changes made to the products table

This SQL scripts include
- Sql queries
- Loops
- Conditional Statement
- DML, DDL, commands
- Variables
<br/>

Files:
- <b>data_table</b>:  Holds query to create a the tables and populate it with data
- <b>sales_procedures</b>: Holds sql code to implement  and excute a procedure that updates sales details/inform about available units based on parameters passed
- <b>update_product_record</b>: Holds sql code to implement and execute a procedure that updates a product quantity and price or adds new record to it, handling product id or name error.


SQL Flavor: PostgreSQL
