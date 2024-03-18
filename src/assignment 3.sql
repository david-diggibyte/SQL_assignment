USE ecommerce;

CREATE TABLE dept_tbl(
      id_deptname VARCHAR(50),
	  emp_name VARCHAR(50),
	  salary INT
  );

SELECT * FROM INFORMATION_SCHEMA.TABLES;

INSERT INTO dept_tbl(id_deptname,emp_name,salary)
           VALUES('1111-MATH', 'RAHUL', 10000),
                 ('1111-MATH', 'RAKESH', 20000),
                 ('2222-SCIENCE', 'AKASH', 10000),
                 ('222-SCIENCE', 'ANDREW', 10000),
                 ('22-CHEM', 'ANKIT', 25000),
                 ('3333-CHEM', 'SONIKA', 12000),
                 ('4444-BIO', 'HITESH', 2300),
                 ('44-BIO', 'AKSHAY', 10000);

SELECT * FROM dept_tbl;

-- 3) Find the total salary of each department

SELECT
    SUBSTRING(id_deptname, CHARINDEX('-', id_deptname) + 1, LEN(id_deptname)) AS dept_name,
    SUM(salary) AS each_dept_total_salary
FROM
    dept_tbl
GROUP BY
    SUBSTRING(id_deptname, CHARINDEX('-', id_deptname) + 1, LEN(id_deptname));