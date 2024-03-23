USE ecommerce;

CREATE TABLE email_signup (
          id INT,
		  email_id VARCHAR(30),
		  signup_date DATE
     );

SELECT * FROM INFORMATION_SCHEMA.TABLES;

INSERT INTO email_signup(id,email_id,signup_date)
               VALUES (1,'Rajesh@Gmail.com','2022-02-01'),
                      (2,'Rakesh_gmail@rediffmail.com','2023-01-22'),
                      (4,'Salil@Gmmail.com','2019-07-05'),
					  (3,'Hitest@Gmail.com','2020-09-08'),
                      (5,'Himanshu@Yahoo.com','2023-05-09'),
                      (6,'Hitesh@Twitter.com','2015-01-01'),
                      (7,'Rakesh@facebook.com',null);

SELECT * FROM email_signup;

-- Write a query to find gmail accounts with latest and first signup date and
--difference between both the dates and also write the query to replace null value with ‘1970-01-01’

SELECT
    COUNT(CASE WHEN LOWER(email_id) LIKE '%gmail.com' THEN 1 END) AS count_gmail_account,
    MAX(CASE WHEN LOWER(email_id) LIKE '%gmail.com' THEN signup_date END) AS latest_signup_date,
    MIN(CASE WHEN LOWER(email_id) LIKE '%gmail.com' THEN signup_date END) AS first_signup_date,
    DATEDIFF(
	          DAY,
	          MIN(CASE WHEN LOWER(email_id) LIKE '%gmail.com' THEN signup_date END),
			  MAX(CASE WHEN LOWER(email_id) LIKE '%gmail.com' THEN signup_date END)
			) AS diff_in_days
FROM
    email_signup;
