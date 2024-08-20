-- create a stored procedure for adding a new product or update the stock unit of an existing one
CREATE OR REPLACE PROCEDURE pr_product_update(pm_product_id INT, pm_product_name VARCHAR(200), pm_price FLOAT, pm_quantity INT)
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
		
		RAISE NOTICE 'Id "%" already assigned to product "%". Use a different Product Id/Correct Product Name', 
			pm_product_id, vr_name_check;
	
	-- If parameter NAME is on the table but parameter ID is not/does not tally
	ELSIF vr_name_exist THEN 
		
		RAISE NOTICE 'Product "%" already exist with different Id "%". Use correct Id/Change Product Name', 
			pm_product_name, vr_id_check;
	
	-- If both parameter ID and NAME does not exist
	ELSIF vr_product_id IS NULL AND vr_product_name IS NULL THEN
		
		-- Insert new record into the product table
		INSERT INTO products (product_id, product_name, price, quantity_sold, quantity_available)
		VALUES
		(pm_product_id, pm_product_name, pm_price, vr_quantity_sold, pm_quantity);
		
		RAISE NOTICE '% unit(s) of "%" added to record', pm_quantity, pm_product_name;
	
	-- If parameter ID and NAME matches in the products table
	ELSE
		-- get quantity available before record update
		SELECT quantity_available
			INTO vr_old_quantity
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
		SELECT quantity_available
			INTO vr_new_quantity
		FROM products
		WHERE product_name = pm_product_name
			AND product_id = pm_product_id;
		
		RAISE NOTICE '% unit(s) added. Product "%" stock unit updated from % to %', 
			pm_quantity, pm_product_name, vr_old_quantity, vr_new_quantity;

	END IF;
	
END;
$$;


-- execute procedure with existing product name and product_id
CALL pr_product_update(1001, 'Wooden Stool', 450000, 5);

-- execute procedure with new product name and product id
CALL pr_product_update(1004, 'Plastic Chair', 98500, 10);

-- execute procedure with existing product name but wrong product_id
CALL pr_product_update(1006, 'Laptop Stand', 98500, 10);

-- execute procedure with existing product id but wrong product name
CALL pr_product_update(1006, 'Laptop Stand', 98500, 10);

-- see product table to check for changes
SELECT * FROM products ;

