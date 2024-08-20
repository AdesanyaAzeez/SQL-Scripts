-- create a data table sales
CREATE TABLE sales
  (
	row_id SERIAL,
	order_date TIMESTAMP DEFAULT NOW(),
	customer_id VARCHAR(20),
	product_id INT,
	units_sold INT,
	total_price FLOAT,
	discount_rate FLOAT,
	FOREIGN KEY (product_id) REFERENCES products(product_id)
  );

-- create a data table products
CREATE TABLE products
  (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(200),
	price FLOAT,
	quantity_sold INT,
	quantity_available INT
  );
	
-- insert sample values into the products table
INSERT INTO products(product_id, product_name, price, quantity_sold, quantity_available)
VALUES
(1001, 'Wooden Stool', 450000, 0, 10),
(1002, 'Office Desk 45m', 350000, 0, 15),
(1003, 'Laptop Stand', 175500, 0, 12);

-- show populated products table
SELECT * FROM products;

