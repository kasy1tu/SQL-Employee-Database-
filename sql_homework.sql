DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS titles;
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
	birth_date DATE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(30),
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
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

COPY titles from '/Users/kasytu/Public/titles.csv'
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
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- Question 3
SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM dept_manager as m
	LEFT JOIN departments as d
	ON (d.dept_no = m.dept_no)
		LEFT JOIN employees as e
		ON (m.emp_no = e.emp_no);

-- Question 4
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments as d
	LEFT JOIN dept_emp as de
	ON (de.dept_no = d.dept_no)
		LEFT JOIN employees as e
		ON (e.emp_no = de.emp_no);

-- Question 5 
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%'

-- Question 6 
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
	JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
		JOIN departments as d 
		ON (d.dept_no = de.dept_no)
		WHERE dept_name = 'Sales';

-- Question 7 
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
	JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
		JOIN departments as d 
		ON (d.dept_no = de.dept_no)
		WHERE dept_name = 'Sales' OR dept_name = 'Development'
		
-- Question 8 
SELECT COUNT(last_name) as "Last Name", last_name
FROM employees
GROUP BY last_name
ORDER BY "Last Name" DESC;



