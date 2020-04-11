-- updates the stock of  a product after a purchase
delimiter $$
CREATE TRIGGER updateProductStock AFTER INSERT ON `order`
 FOR EACH ROW
	IF NEW.gift_shop_id != 11 -- if the product is not a ticket
    THEN
		  UPDATE product SET product.stock = product.stock - NEW.quantity WHERE product.product_id = NEW.product_id AND product.product_size = NEW.product_size;
    END IF $$
delimiter ;

-- inserts into the store_supply_alerts table (update this in db!!!!!!!!)
DELIMITER $$
CREATE TRIGGER low_store_supplies 
AFTER UPDATE ON `product` FOR EACH ROW
BEGIN
	IF  -- if we are below 20% of the target stock and the same alert for the same product hasn't been created today 
    NEW.stock < (0.2*NEW.target_stock)  
    AND
    (NEW.product_id, NEW.product_size, DATE(now())) NOT IN (SELECT store_supply_alerts.product_id, store_supply_alerts.product_size, store_supply_alerts.date_generated FROM store_supply_alerts)
    THEN
		INSERT INTO store_supply_alerts VALUES(NEW.product_id, NEW.product_size, (SELECT manager_id FROM department WHERE NEW.gift_shop_id = department.department_id) , (SELECT DATE(now())));
	END IF;
END$$
DELIMITER ;


-- inserts into the zoo_supply alerts when food supply is too low
DELIMITER $$
CREATE TRIGGER low_food_supplies 
AFTER UPDATE ON `food_supply` FOR EACH ROW
BEGIN
	IF  -- if we are below 20% of the target stock and the same alert for the same product hasn't been created today 
    NEW.stock < (0.2*NEW.target_stock) 
    AND
    (NEW.food_id, (SELECT manager_id FROM department WHERE department.department_id = 12), DATE(now())) NOT IN (SELECT * FROM zoo_supply_alerts)
    THEN
		INSERT INTO zoo_supply_alerts VALUES(NEW.food_id, (SELECT manager_id FROM department WHERE department_id = 12), (SELECT DATE(now())));
	END IF;
END$$
DELIMITER ;


-- inserts into the zoo_supply alerts when medicine supply is too low
DELIMITER $$
CREATE TRIGGER low_med_supplies 
AFTER UPDATE ON `medicine_supply` FOR EACH ROW
BEGIN
	IF -- if we are below 20% of the target stock and the same alert for the same product hasn't been created today 
    NEW.stock < (0.2*NEW.target_stock) 
    AND
    (NEW.med_id, (SELECT manager_id FROM department WHERE department.department_id = 9), DATE(now())) NOT IN (SELECT * FROM zoo_supply_alerts)
    THEN
		INSERT INTO zoo_supply_alerts VALUES(NEW.med_id, (SELECT manager_id FROM department WHERE department_id = 9), (SELECT DATE(now())));
	END IF;
END$$
DELIMITER ;


--  notifies all carers if their animal gets sick, healthy, pregnant, dead
DELIMITER $$
CREATE TRIGGER animal_health_change 
  AFTER UPDATE ON `animal` FOR EACH ROW
  BEGIN
    DECLARE caretaker INT;
    DECLARE exit_loop BOOLEAN;
    DECLARE carers CURSOR FOR SELECT caretaker_id FROM takes_care_of WHERE NEW.animal_id = takes_care_of.animal_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop=TRUE;
    IF 
    NEW.`status` != OLD.`status` 
    THEN
		  OPEN carers;
        myLoop: LOOP
        FETCH carers INTO caretaker;
        IF exit_loop THEN 
          CLOSE carers;
          LEAVE myLoop;
		    END IF;
		    INSERT INTO caretaker_alerts VALUES(NEW.animal_id, caretaker, (SELECT DATE(now())), NEW.status);
	      END LOOP myLoop;
    END IF;
  END$$
DELIMITER ;
