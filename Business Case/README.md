# Business Use Case: Online Retail Store

## Implemented with MySQL

This folder holds scripts for a business case scenario created by AI.

Scenario:
You've been hired by an online retail store that sells various products. The store wants to manage its inventory, customer orders, and sales data efficiently. 
Your task is to design a relational database to meet their requirements.

Database Design:

**1. Tables:**
   - Products: Contains information about each product.
     - Columns: product_id, product_name, category, unit_price, stock_quantity
     
   - Customers: Stores customer details.
     - Columns: customer_id, first_name, last_name, email, phone
     
   - Orders: Records customer orders.
     - Columns: order_id, customer_id, order_date, total_amount

   - Order_Items: Represents individual items within an order.
     - Columns: order_item_id, order_id, product_id, quantity, order_amount, amount_sold

    
**2. Business Case Questions**
   - Total Revenue: Calculate the total revenue generated by the store.
     
   - Average Order Value: Calculate the average order value.
     
   - Top-Selling Products: Identify the top-selling products based on the quantity sold.
     
   - Customer Orders: Retrieve details of all orders placed by a specific customer.
     
   - Stock count: How many quantity of products are left after sales?
     
   - Low Stock Products: Find products with low stock (less than 10 units) after sales

  
