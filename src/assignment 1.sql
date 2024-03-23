-- First Assignment

-- 1) Create a Database as ecommerce

CREATE DATABASE ecommerce;

USE ecommerce;

-- 2) Create 4 tables (gold_member_users, users, sales, product)

CREATE TABLE gold_member_users(
             userid VARCHAR(50),
			 signup_date DATE
          );

CREATE TABLE users(
          userid VARCHAR(50),
		  signup_date DATE
         );

CREATE TABLE sales(
           userid VARCHAR(50),
		   created_date DATE,
		   product_id INT
		);

CREATE TABLE product(
           product_id INT,
		   product_name VARCHAR(50),
		   price INT
		);

-- 3)Insert the values provided above with respective datatypes

INSERT INTO gold_member_users(userid,signup_date)
            VALUES ('John','09-22-2017'), ('Mary','04-21-2017');

SELECT * FROM gold_member_users;

INSERT INTO users( userid, signup_date)
            VALUES ('John','09-02-2014'), ('Michel','01-15-2015'), ('Mary','04-11-2014');

SELECT * FROM users;

INSERT INTO sales(userid,created_date,product_id)
           VALUES ('John','04-19-2017',2),('Mary','12-18-2019',1), ('Michel','07-20-2020',3),
		          ('John','10-23-2019',2), ('John','03-19-2018',3), ('Mary','12-20-2016',2),
		          ('John','11-09-2016',1), ('John','05-20-2016',3), ('Michel','09-24-2017',1),
		          ('John','03-11-2017',2), ('John','03-11-2016',1), ('Mary','11-10-2016',1),
		          ('Mary','12-07-2017',2);

SELECT * FROM sales;

INSERT INTO product(product_id,product_name,price)
            VALUES (1,'Mobile',980), (2,'Ipad',870), (3,'Laptop',330);

SELECT * FROM product

-- 4) Show all the tables in the same database(ecommerce)

SELECT name
FROM sys.tables;

SELECT *
FROM INFORMATION_SCHEMA.TABLES;

-- 5) Count all the records of all four tables using single query

SELECT
(SELECT COUNT(*) FROM gold_member_users) AS gold_member_users_count,
(SELECT COUNT(*) FROM users) AS users_count,
(SELECT COUNT(*) FROM sales) AS sales_count,
(SELECT COUNT(*) FROM product) AS product_count ;

-- 6) What is the total amount each customer spent on ecommerce company

SELECT * FROM sales;
SELECT * FROM product;

SELECT s.userid,SUM(p.price) AS total_amount_each_customer_spent
FROM sales AS s
INNER JOIN product AS p
ON s.product_id = p.product_id
GROUP BY s.userid

-- 7) Find the distinct dates of each customer visited the website:
-- output should have 2 columns date and customer name.

SELECT DISTINCT created_date AS date, userid AS customer_name
FROM sales
ORDER BY date;

-- 8) Find the first product purchased by each customer using 3 tables(users, sales, product)

SELECT * FROM users;
SELECT * FROM sales;
SELECT * FROM product;

SELECT u.userid, MIN(s.created_date) AS first_purchase_date, p.product_name
FROM users AS u
INNER JOIN sales AS s
ON u.userid = s.userid
INNER JOIN product  AS p
ON s.product_id = p.product_id
GROUP BY u.userid , p.product_name;

-- 9)  dWhat is the most purchased item of each customer and how many times the customer has purchased it.
-- output should have 2 columns count of the items as item_count and customer name

SELECT COUNT(product.product_name) AS item_count , sales.userid AS customer_name
FROM sales
INNER JOIN product
ON sales.product_id = product.product_id
GROUP BY sales.userid
ORDER BY item_count DESC;


-- 10) Find out the customer who is not the gold_member_user

SELECT * FROM users
WHERE userid NOT IN (SELECT userid FROM gold_member_users);

-- 11) What is the amount spent by each customer when he was the gold_member user

SELECT g.userid AS gold_member_users, SUM(product.price) AS total_amout
FROM gold_member_users AS g
INNER JOIN sales
ON g.userid =sales.userid
INNER JOIN product
ON sales.product_id = product.product_id
GROUP BY g.userid;

-- 12) Find the Customers names whose name starts with M

SELECT userid AS customers_name
FROM sales
WHERE userid LIKE 'M%';

-- 13) Find the Distinct customer Id of each customer

SELECT DISTINCT userid AS customer_name
FROM sales;

-- 14) Change the Column name from product table as price_value from price

EXEC sp_rename 'product.price','price_value','COLUMN';
SELECT * FROM product;

-- 15) Change the Column value product_name – Ipad to Iphone from product table

UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad' ;

SELECT * FROM product;

-- 16) Change the table name of gold_member_users to gold_membership_users

EXEC sp_rename 'gold_member_users','gold_membership_users';

SELECT * FROM gold_membership_users;

-- 17) Create a new column  as Status in the table crate above gold_membership_users
-- the Status values should be 2 Yes and No if the user is gold member,
-- then status should be Yes else No.

ALTER TABLE gold_membership_users
ADD status VARCHAR(10) DEFAULT 'No';

UPDATE gold_membership_users
SET status = 'Yes' ;

SELECT * FROM gold_membership_users;

-- 18) Delete the users_ids 1,2 from users table and roll the back changes
-- once both the rows are deleted one by one mention the result when performed roll back.

BEGIN TRANSACTION;
DELETE FROM users WHERE userid = 'John' ;
ROLLBACK;

SELECT * FROM users;

BEGIN TRANSACTION;
DELETE FROM users WHERE userid = 'Michel';
ROLLBACK;

-- 19) Insert one more record as same (3,'Laptop',330) as product table

INSERT INTO product(product_id,product_name,price_value) VALUES(3,'Laptop',330);
SELECT * FROM product;

-- 20) Write a query to find the duplicates in product table

SELECT product_name,COUNT(*) AS duplicate
FROM product
GROUP BY product_name
HAVING COUNT(*) > 1;
