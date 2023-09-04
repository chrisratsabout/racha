-- database racha
BEGIN TRANSACTION;

-- *************************************************************************************************
-- Drop all db objects in the proper order
-- *************************************************************************************************
DROP TABLE IF EXISTS cart_item;
DROP TABLE IF EXISTS menu_item;
DROP TABLE IF EXISTS users;

-- *************************************************************************************************
-- Create the tables and constraints
-- *************************************************************************************************

--users (name is pluralized because 'user' is a SQL keyword)
CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	name varchar(50) NOT NULL,
	address varchar(100) NULL,
	city varchar(50) NULL,
	state_code char(2) NULL,
	zip varchar(5) NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

-- menu_item
CREATE TABLE menu_item (
	menu_item_id SERIAL,
	name varchar(50) NOT NULL,
    description varchar,
	price decimal(8,2) NOT NULL,
	CONSTRAINT PK_menu_item PRIMARY KEY (menu_item_id)
);

-- cart item
CREATE TABLE cart_item (
	cart_item_id SERIAL,
	user_id int NOT NULL,
	menu_item_id int NOT NULL,
	quantity int NOT NULL DEFAULT(1),
	CONSTRAINT PK_cart_item PRIMARY KEY (cart_item_id),
	CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT FK_cart_item_menu_item FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id)
);
CREATE UNIQUE INDEX IX_cart_item_user_menu_item ON cart_item(user_id, menu_item_id);

-- *************************************************************************************************
-- Insert some sample starting data
-- *************************************************************************************************

-- Users
-- Password for all users is password
INSERT INTO users (username,password_hash,role, name, address, city, state_code, zip) VALUES 
    ('user', '$2a$10$tmxuYYg1f5T0eXsTPlq/V.DJUKmRHyFbJ.o.liI1T35TFbjs2xiem','ROLE_USER',  'Jack O''Lantern', null, 'Cleveland', 'OH', '44123'),
    ('admin','$2a$10$tmxuYYg1f5T0eXsTPlq/V.DJUKmRHyFbJ.o.liI1T35TFbjs2xiem','ROLE_ADMIN', 'Jill O''Lantern', null, 'Beverly Hills', 'CA', '90210');

-- Products
INSERT INTO menu_item (name, description, price) VALUES 
    ('Hokkaido Milk Tea', 'Black milk tea w/toffee flavor + pearls', 5.75),
    ('Lavender Earl Grey Milk Tea', NULL, 5.75),
    ('Cookies n Cream', NULL, 6.00),
    ('Fresh Taro Milk Tea', NULL, 5.75),
    ('Pandan Mungbean Milk Tea', NULL, 5.50),
    ('Thai Tea', NULL, 4.50),
    ('Green Thai Tea', NULL, 4.50),
    ('Strawberry Matcha Latte', NULL, 6.25),
    ('Love Triangle', 'Strawberry, mango, and passion gruit green tea with mango jelly', 5.75),
    ('Just Peachy', 'White peach oolong tea w/lynchee jelly', 5.75),
    ('Fruitea Peebles', 'Orange and pineapple black tea with mango jelly', 5.75),
    ('Fruitea Way', 'Strawberry tea w/seasonal cut up fruit', 6.25),
    ('Off To Neverland', 'Butterfly pea tea sparkling virgin mojito w/lime slices and mint', 5.25),
    ('Your Spark', 'Probiotic yogurt w/sparkling water + choice of flavor -peach, orange, mango, passion fruit, strawberry, or lychee', 5.50),
    ('Sweet N Salty', 'Sparkling Vietnamese saled plum lemonade', 5.00),
    ('Fifty/Fifty', 'Half black tea and half Vietnamese coffee', 5.00),
    ('Vietnamese Iced Coffee', 'Robusta coffee w/condensed milk', 4.50),
    ('Coconut Coffee', 'Robusta coffee w/condensed milk + coconut milk/cream', 5.25),
    ('Banh Mi Dac Biet', 'Bbq pork, headcheese, pork bologna, and pate', 6.50),
    ('Banh Mi Thit Nuong', 'Choice one one: chicken, beef, pork', 6.00),
    ('Banh Mi Bi', 'Shredded pork', 5.50),
    ('Banh Mi Cha Lua Pate', 'Pork bologna, and pate', 6.00),
    ('Banh Mi Xiu Mai', 'Pork meatballs w/cucumber + green onions', 6.00),
    ('Banh Mi Chay', 'Bbq bean curd', 6.00)
   ;

-- Carts
INSERT INTO cart_item(user_id, menu_item_id, quantity) VALUES
    (1, 2, 3),
    (1, 4, 1),
    (1, 1, 2);



COMMIT TRANSACTION;
