DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS title;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS salaries;



CREATE TABLE departments(
	dept_no VARCHAR(30) PRIMARY KEY,
	dept_name VARCHAR(30)
);

CREATE TABLE titles(
	title_id VARCHAR(30) PRIMARY KEY,
	title VARCHAR(30)
);

CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(30), 
	birth_date VARCHAR(30),
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(30),
	hire_date VARCHAR(30),
	FOREIGN KEY (emp_title_id) REFERENCES title(title_id)
);

CREATE TABLE dept_emp(
	emp_no INT, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(30),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no, dept_no)
);

CREATE TABLE salaries(
	emp_no INT, 
	salary INT, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(30), 
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

COPY departments from '/Users/kasytu/Public/departments.csv'
DELIMITER ',' CSV HEADER;

COPY title from '/Users/kasytu/Public/titles.csv'
DELIMITER ',' CSV HEADER;

COPY employees from '/Users/kasytu/Public/employees.csv'
DELIMITER ',' CSV HEADER;

COPY dept_emp from '/Users/kasytu/Public/dept_emp.csv'
DELIMITER ',' CSV HEADER;

COPY salaries from '/Users/kasytu/Public/salaries.csv'
DELIMITER ',' CSV HEADER;

COPY dept_manager from '/Users/kasytu/Public/dept_manager.csv'
DELIMITER ',' CSV HEADER;

-- Question 1
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON
e.emp_no=s.emp_no;

-- Question 2 ?
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1/1/1986' AND hire_date <= '12/31/1986';

-- Question 3
SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM dept_manager as m
	JOIN departments as d
	ON (d.dept_no = m.dept_no)
		JOIN employees as e
		ON (m.emp_no = e.emp_no);

-- Question 4
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments as d
	JOIN dept_emp as de
	ON (de.dept_no = d.dept_no)
		JOIN employees as e
		ON (e.emp_no = de.emp_no)
