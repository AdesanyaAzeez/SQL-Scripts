DROP DATABASE IF EXISTS `online_retail_store`;	-- check if database exist, if yes, delete
CREATE DATABASE `online_retail_store`;			-- create the retail store database
USE `online_retail_store`;						-- declare to use the retail store database

-- create products table and specify columns, data type and constraints
CREATE TABLE products(
	product_id INT NOT NULL AUTO_INCREMENT, 
    product_name VARCHAR(50), 
    category VARCHAR(50), 
    unit_price DOUBLE, 
    stock_quantity DOUBLE,
    PRIMARY KEY(product_id)
);

-- create customers table and specify columns, data type and constraints    
CREATE TABLE customers(
	customer_id INT NOT NULL, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    email VARCHAR(70), 
    phone VARCHAR(20),
    PRIMARY KEY(customer_id)
);

-- create orders table and specify columns, data type and constraints
CREATE TABLE orders(
	order_id INT NOT NULL, 
    customer_id INT NOT NULL, 
    order_date DATE, 
    total_amount DOUBLE, 
    PRIMARY KEY(order_id),
	FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- create order_items table and specify columns, data type and constraints
CREATE TABLE order_items(
	order_item_id INT NOT NULL, 
    order_id INT NOT NULL, 
    product_id INT NOT NULL, 
    quantity DOUBLE, 
    order_amount DOUBLE,
    amount_sold DOUBLE,
    PRIMARY KEY(order_item_id),
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

-- insert values into the products table
INSERT INTO products (product_name, category, unit_price, stock_quantity)
VALUES
('Laptop', 'Electronics', 800, 50),
('Smartphone', 'Electronics', 500, 100),
('T-shirt', 'Apparel', 20, 200),
('Trousers', 'Apparel', 50, 125),
('Headset', 'Electronics', 150, 200);

-- insert values into the customers table
INSERT INTO customers (customer_id, first_name, last_name, email, phone)
VALUES
(101, 'John', 'Doe', 'john.doe@sample.com', '+1 123-456-7890'),
(102, 'Jane', 'Smith', 'jane.smith@sample.com', '+1 987-654-3210');

-- insert values into the orders table
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
(1001, 101, '2024-03-10', 3500),
(1002, 102, '2024-03-11', 500),
(1003, 102, '2024-03-15', 75);

-- insert values into the order_items table
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, order_amount, amount_sold)
VALUES
(2001, 1001, 1, 2, 1600, 1500),
(2002, 1001, 2, 3, 1500, 2000),
(2003, 1002, 3, 5, 100, 500),
(2004, 1003, 3, 4, 80, 75);

