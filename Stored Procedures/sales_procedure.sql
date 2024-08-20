-- create a stored procedure to enter sales record into the sales table and consider giving discount based on certain conditions
CREATE OR REPLACE PROCEDURE pr_sales_record (pm_cust_id VARCHAR(20), pm_product_name VARCHAR(200), pm_quantity INT)
LANGUAGE plpgsql
AS $$
DECLARE
	vr_product_count INT;
	vr_quantity_check INT;
	vr_product_id INT;
	vr_price FLOAT;
	vr_discount_rate FLOAT;
	vr_product_list RECORD;
	
BEGIN

	-- check if product and ordered unit is available and in stock
	SELECT COUNT(*)
		INTO vr_product_count
	FROM products
	WHERE product_name = pm_product_name
		AND quantity_available >= pm_quantity;
	
	-- check for unit of ordered product
	SELECT quantity_available 
		INTO vr_quantity_check
	FROM products
	WHERE product_name = pm_product_name;
	
	-- if customer has bought item worth 750000 or purchased 8 times or more, then give 20% discount
	SELECT 
		CASE
			WHEN COUNT(*) >= 8 OR SUM(total_price) >= 750000 
			THEN 0.2
		ELSE 0.0 END
		INTO vr_discount_rate
	FROM sales
	WHERE customer_id = pm_cust_id;
	
	-- if product and unit is available
	IF vr_product_count > 0 THEN
	
		-- get product_id and price
		SELECT product_id, price
			INTO vr_product_id, vr_price
		FROM products
		WHERE product_name = pm_product_name;
		
		-- insert order record into SALES table and consider discount if applicable
		INSERT INTO sales (customer_id, product_id, units_sold, total_price, discount_rate)
		VALUES
		(pm_cust_id, vr_product_id, pm_quantity, (pm_quantity * vr_price) - ((pm_quantity * vr_price) * vr_discount_rate), vr_discount_rate);
		
		-- update PRODUCT table for record keeping
		UPDATE products
		SET quantity_sold = (quantity_sold + pm_quantity),
			quantity_available = (quantity_available - pm_quantity)
		WHERE product_name = pm_product_name;
		
		-- display this after record is updated
		RAISE NOTICE 'ITEM SOLD AND RECORD UPDATED SUCCESSFULLY!';
		RAISE NOTICE 'Product: %, Units: %, Totalprice: %', pm_product_name, pm_quantity, (pm_quantity * vr_price);
	
	-- if ordered unit is more than what's in stock
	ELSIF vr_quantity_check < pm_quantity THEN
		RAISE NOTICE 'OUT OF STOCK! ONLY % UNIT(S) AVAILABLE', vr_quantity_check;
	
	-- if product is not available at all
	ELSE
		RAISE NOTICE 'PRODUCT NOT AVAILABLE!';
		RAISE NOTICE 'ITEMS IN STOCK';

    -- for loop to list all available products and their respective price in the products table
		FOR vr_product_list IN
    	SELECT product_name, price FROM products
			LOOP
			-- Pass the column values into the RAISE NOTICE statement
			RAISE NOTICE '% @ %', vr_product_list.product_name, vr_product_list.price;
		END LOOP;
		
	END IF;
	
END;
$$;

-- execute the stored procedure with an available product and unit
CALL pr_sales_record('CST-101', 'Wooden Stool', 5);

-- select product table to see changes in quantity sold & available
SELECT * FROM products;
-- select sales table to see new inserted record
SELECT * FROM sales;

-- execute the stored procedure with a product not available
CALL pr_sales_record('CST-101', 'Office 360 Chair', 5);

-- execute the stored procedure with an available product but excess unit than what's in stock
CALL pr_sales_record('CST-101', 'Wooden Stool', 20);

