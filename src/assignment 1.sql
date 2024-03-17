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