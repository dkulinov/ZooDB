CREATE DATABASE `zoo`;

USE `zoo`;

CREATE TABLE `food_supply`
(
    `food_id` INT NOT NULL AUTO_INCREMENT, 
    `food_name` VARCHAR(50),
    `stock` INT NOT NULL,
    PRIMARY KEY (`food_id`)
);

CREATE TABLE `medicine_supply`
(
    `med_id` INT NOT NULL AUTO_INCREMENT,
    `med_name` VARCHAR(50),
    `stock` INT NOT NULL,
    PRIMARY KEY (`med_id`)
);

/* name is for what we call an enclosure ex. the bat cave type is the biome/ecosystem  */
CREATE TABLE `enclosure`
(
    `enclosure_id` INT NOT NULL AUTO_INCREMENT,
    `enclosure_name` VARCHAR(50),
    `enclosure_description` VARCHAR(200),
    `enclosure_capacity` INT,
    `ecosystem_type` ENUM('AQUATIC', 'RAINFOREST', 'ARCTIC', 'DESERT'),
    PRIMARY KEY (`enclosure_id`)
);

CREATE TABLE `animal`
(
    `animal_id` INT NOT NULL AUTO_INCREMENT,
    `animal_name` VARCHAR(30),
    `species` VARCHAR(30),
    `admission` DATE,
    `age` INT,
    `gender` ENUM('M', 'F'),
    `enclosure_id` INT,
    `status` ENUM('healthy','sick', 'pregnant','deceased'),
    `diet_type` ENUM('Herbivorous', 'Carnivorous', 'Omnivorous'),
    `feedings_per_day` INT NOT NULL,
    PRIMARY KEY (`animal_id`)
);

CREATE TABLE `takes_care_of`
(
    `caretaker_id` INT NOT NULL,
    `animal_id` INT NOT NULL,
    PRIMARY KEY(`caretaker_id`, `animal_id`)
);

/*includes gift shops*/
CREATE TABLE `department`
(
    `department_id` INT NOT NULL AUTO_INCREMENT,
    `department_name` VARCHAR(30),
    `manager_id` INT,
    PRIMARY KEY (`department_id`)
);

/* when inserting use an encryption function
   didnt include address and phone cause more of HR thing*/
CREATE TABLE `employee`
(
    `employee_id` INT NOT NULL AUTO_INCREMENT,
    `pswd` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(50),
    `last_name` VARCHAR(50),
    `supervisor_id` INT,
    `department_id` INT,
    PRIMARY KEY (`employee_id`)
);

CREATE TABLE `customer`
(
    -- `customer_id` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(255),
    `f_name` VARCHAR(30),
    `l_name` VARCHAR(30),
    `pswd` VARCHAR(255) NOT NULL,
    `isMember` BOOLEAN NOT NULL DEFAULT 0,
    `date_registered` TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (`email`)
);

/* all products including tickets 
   if stock is null then its a ticket(unlimited)*/
CREATE TABLE `product`
(
    `product_id` INT NOT NULL AUTO_INCREMENT,
    `product_size` ENUM('XS','S','M','L','XL','NA') DEFAULT 'NA',
    `product_name` VARCHAR(50),
    `gift_shop_id` INT,   /* can be null if its a ticket */
    `price` DECIMAL(5,2) NOT NULL,
    `stock` INT,
    `image` LONGBLOB,
    PRIMARY KEY (`product_id`, `product_size`)
);

/* if email is null then its a in person order */
CREATE TABLE `order`
(
    `order_id` INT NOT NULL AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `order_date` TIMESTAMP NOT NULL DEFAULT NOW(),
    `price_total` DECIMAL(5,2),
    `quantity` INT NOT NULL DEFAULT 1,
    `email` VARCHAR(255),
    `in_store` BOOLEAN NOT NULL DEFAULT 1,
    PRIMARY KEY(`order_id`)
);

CREATE TABLE `animal_health`  /* might want to rename this table */
(
    `animal_id` INT NOT NULL,
    `med_id` INT,
    `dose_amount` INT,
    `dose_frequency` ENUM('daily', 'weekly', 'monthly', 'yearly'),
    'last_prescribed' DATE,   /* used so that care takers know when they need to give medicine etc */
    PRIMARY KEY(`animal_id`, `med_id`)
);

CREATE TABLE `animal_diet`
(
    `animal_id` INT,
    `food_id` INT NOT NULL,
    `serving_size_in_grams` INT, 
    PRIMARY KEY(`animal_id`, `food_id`)
);

CREATE TABLE `attraction`
(
    `attraction_id` INT,
    `attraction_name` VARCHAR(50),
    `capacity` INT,
    `attraction_status` ENUM('under construction', 'open', 'closed', 'under repair', 'needs repair'),
    PRIMARY KEY(`attraction_id`),
    FOREIGN KEY(`attraction_id`) REFERENCES `department`(`department_id`)
);


ALTER TABLE `animal`
	ADD FOREIGN KEY (`enclosure_id`) REFERENCES `enclosure`(`enclosure_id`);
	
ALTER TABLE `department`
    ADD FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`);
	
ALTER TABLE `employee`
	ADD FOREIGN KEY (`supervisor_id`) REFERENCES `employee`(`employee_id`),
    ADD FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`);
	
ALTER TABLE `product`
	ADD FOREIGN KEY (`gift_shop_id`) REFERENCES `department`(`department_id`);
	
ALTER TABLE `order`
	ADD FOREIGN KEY(`product_id`) REFERENCES `product`(`product_id`),
    ADD FOREIGN KEY(`email`) REFERENCES `customer`(`email`); /* will be null if in person order */

ALTER TABLE `animal_health`
	ADD FOREIGN KEY(`animal_id`) REFERENCES `animal`(`animal_id`),
    ADD FOREIGN KEY(`med_id`) REFERENCES `medicine_supply`(`med_id`);
	
ALTER TABLE `animal_diet`
	ADD FOREIGN KEY(`animal_id`) REFERENCES `animal`(`animal_id`),
    ADD FOREIGN KEY(`food_id`) REFERENCES `food_supply`(`food_id`);
	
ALTER TABLE `takes_care_of`
    ADD FOREIGN KEY(`caretaker_id`) REFERENCES `employee`(`employee_id`),
    ADD FOREIGN KEY(`animal_id`) REFERENCES `animal`(`animal_id`);