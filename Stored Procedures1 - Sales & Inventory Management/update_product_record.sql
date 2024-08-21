-- create a stored procedure for adding a new product/updating the product details of an existing one and keeping a record of all events
CREATE OR REPLACE PROCEDURE pr_product_update(pm_product_id INT, pm_product_name VARCHAR(200), pm_price FLOAT, pm_quantity INT, pm_narration VARCHAR(100))
LANGUAGE plpgsql 
AS $$
DECLARE
	vr_product_id INT;
	vr_name_check VARCHAR(200);
	vr_id_check VARCHAR(200);
	vr_product_name VARCHAR(200);
	vr_quantity_sold INT DEFAULT 0;
	vr_new_quantity INT;
	vr_old_quantity INT;
	vr_old_price FLOAT;
	vr_new_price FLOAT;
	vr_id_exist BOOLEAN;
	vr_name_exist BOOLEAN;
	
BEGIN 
	-- use ID parameter to check for product ID and NAME
	SELECT product_id, product_name
		INTO vr_product_id, vr_name_check
	FROM products
	WHERE product_id = pm_product_id;
	
	-- use NAME parameter to check for product ID and NAME
	SELECT product_name, product_id
		INTO vr_product_name, vr_id_check
	FROM products
	WHERE product_name = pm_product_name;
	
	-- check if ID parameter exist but does not tally with NAME parameter on the table
	SELECT EXISTS (
        SELECT 1
        FROM products
        WHERE product_id = pm_product_id
			AND product_name != pm_product_name
	) INTO vr_id_exist;
	
	-- check if NAME parameter exist but does not tally with ID parameter on the table
	SELECT EXISTS (
        SELECT 1
        FROM products
        WHERE product_name = pm_product_name
			AND product_id != pm_product_id
	) INTO vr_name_exist;
	
	-- If parameter ID is on the table but parameter NAME is not/does not tally
	IF vr_id_exist THEN
		-- show error message 
		RAISE NOTICE 'Id "%" already assigned to product "%". Use a different Product Id/Correct Product Name', 
			pm_product_id, vr_name_check;
	
	-- If parameter NAME is on the table but parameter ID is not/does not tally
	ELSIF vr_name_exist THEN 
		-- show error message
		RAISE NOTICE 'Product "%" already exist with different Id "%". Use correct Id/Change Product Name', 
			pm_product_name, vr_id_check;
	
	-- Else If both parameter ID and NAME does not exist
	ELSIF vr_product_id IS NULL AND vr_product_name IS NULL THEN
		
		-- Insert new record into the product table
		INSERT INTO products (product_id, product_name, price, quantity_sold, quantity_available)
		VALUES
		(pm_product_id, pm_product_name, pm_price, vr_quantity_sold, pm_quantity);

		-- show details of new product added to record
		RAISE NOTICE '% unit(s) of "%" @ % added to record', pm_quantity, pm_product_name, pm_price;
	
	-- Otherwise If parameter ID and NAME matches in the products table
	ELSE
		-- get quantity available before record update
		SELECT quantity_available, price
			INTO vr_old_quantity, vr_old_price
		FROM products
		WHERE product_name = pm_product_name
			AND product_id = pm_product_id;
		
		-- update the details of parameter ID and NAME
		UPDATE products
		SET price = pm_price,
			quantity_available = (quantity_available + pm_quantity)
		WHERE product_name = pm_product_name
			AND product_id = pm_product_id;
		
		-- get quantity available after record update
		SELECT quantity_available, price
			INTO vr_new_quantity, vr_new_price
		FROM products
		WHERE product_name = pm_product_name
			AND product_id = pm_product_id;

		-- if price remains same
		IF vr_old_price = vr_new_price THEN
			-- show unit update details
			RAISE NOTICE 'Product "%" Details Updated. Unit updated from % to %', 
				pm_product_name, vr_old_quantity, vr_new_quantity;
				
		-- if quantity remains same	
		ELSIF vr_old_quantity = vr_new_quantity THEN
			-- show price update details
			RAISE NOTICE 'Product "%" Details Updated. Price updated from % to %',
				pm_product_name, vr_old_price, vr_new_price;

		-- if both price and quantity changes		
		ELSE
			RAISE NOTICE 'Product "%" Details Updated. Price updated from % to %, and units from % to %',
				pm_product_name, vr_old_price, vr_new_price, vr_old_quantity, vr_new_quantity;
		END IF;

	END IF;

	-- if there's no mismatch in product id/name 
	IF NOT (vr_id_exist OR vr_name_exist) THEN
		-- insert update details into the PRODUCT HISTORY table
		INSERT INTO product_history(product_id, price, unit_added, created_at, narration)
		VALUES
		(pm_product_id, pm_price, pm_quantity, NOW(), pm_narration);
		-- show success message
		RAISE NOTICE 'Record history update successful';
	END IF;

END;
$$;



-- execute procedure with existing product name and product_id, updating product unit
CALL pr_product_update(1001, 'Wooden Stool', 450000, 5, 'Update product quantity');

-- execute procedure with existing product name and product_id, updating price
CALL pr_product_update(1001, 'Wooden Stool', 450500, 0, 'Update product price');

-- execute procedure with new product name and product id
CALL pr_product_update(1004, 'Plastic Chair', 98500, 10, 'New product added');

-- execute procedure with existing product name but wrong product_id
CALL pr_product_update(1006, 'Laptop Stand', 98500, 10);

-- execute procedure with existing product id but wrong product name
CALL pr_product_update(1006, 'Laptop Stand', 98500, 10);


-- see product table to check for changes
SELECT * FROM products ;

-- see product history table for record history
SELECT * FROM product_history ;

