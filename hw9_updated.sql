DROP TABLE IF EXISTS departments,dept_emp,dept_manager,employees,salaries,titles;

CREATE TABLE "titles" (
    "title_id" VARCHAR NOT NULL primary key,
    "title" VARCHAR NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER  NOT NULL primary key,
    "emp_title_id" VARCHAR NOT NULL,
    "birth_date" VARCHAR  NOT NULL,
    "first_name" VARCHAR  NOT NULL,
    "last_name" VARCHAR  NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" date NOT NULL,
	Foreign key ("emp_title_id") references titles("title_id")
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR  NOT NULL primary key,
    "dept_name" VARCHAR  NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR  NOT NULL,
    "emp_no" INTEGER   NOT NULL,
	Foreign key ("emp_no") references employees("emp_no"),
	Foreign key ("dept_no") references departments("dept_no"),
	primary key ("dept_no","emp_no")
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR  NOT NULL,
	Foreign key ("emp_no") references employees("emp_no"),
	Foreign key ("dept_no") references departments("dept_no"),
	primary key ("dept_no","emp_no")
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER  NOT NULL primary key,
    "salary" INTEGER  NOT NULL,
	Foreign key("emp_no") references employees("emp_no")
);

-- Show all data for each table
SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees; 
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;


-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees 
JOIN salaries 
ON employees.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;
