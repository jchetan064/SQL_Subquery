/* CREATE TABLE Employees_Subquery (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Department VARCHAR(30),
    Salary INT,
    Manager_ID INT
);

INSERT INTO Employees_Subquery VALUES
(101,'Amit','HR',45000,110),
(102,'Neha','HR',50000,110),
(103,'Raj','HR',55000,110),
(104,'Priya','IT',70000,120),
(105,'Mohit','IT',85000,120),
(106,'Karan','IT',95000,120),
(107,'Simran','Finance',60000,130),
(108,'Deepak','Finance',75000,130),
(109,'Anjali','Finance',90000,130),
(110,'Vivek','HR',120000,NULL),
(111,'Rohit','Sales',55000,140),
(112,'Sneha','Sales',65000,140),
(113,'Pooja','Sales',70000,140),
(114,'Rahul','Marketing',50000,150),
(115,'Nisha','Marketing',65000,150),
(116,'Arjun','Marketing',80000,150),
(117,'Meera','IT',72000,120),
(118,'Akash','Finance',68000,130),
(119,'Riya','Sales',52000,140),
(120,'Suresh','IT',140000,NULL),
(121,'Kavya','HR',48000,110),
(122,'Manish','Sales',60000,140),
(123,'Tanu','Finance',72000,130),
(124,'Harsh','Marketing',58000,150),
(125,'Aditi','IT',88000,120),
(126,'Gaurav','Finance',95000,130),
(127,'Sonia','Sales',73000,140),
(128,'Vikram','Marketing',85000,150),
(130,'Alok','Finance',135000,NULL),
(140,'Rakesh','Sales',125000,NULL),
(150,'Pankaj','Marketing',130000,NULL); */

/* Easy */
select * from Employees_Subquery

/* Find employees earning more than the average salary. */
select * from Employees_Subquery where salary > (select AVG(salary) from Employees_Subquery);


/* Find employees earning less than the average salary. */
select * from Employees_Subquery where salary < (select AVG(salary) from Employees_Subquery);


/* Find the highest-paid employee. */
select MAX(salary) "Highest Salary" from Employees_Subquery;


/* Find the second-highest salary. */
select MAX(salary) "Second Highest Salary" from Employees_Subquery where salary < (select MAX(salary) from Employees_Subquery);


/* Find employees earning the minimum salary. */
select Min(salary) "Highest Salary" from Employees_Subquery;


/* Find employees who work in the same department as Amit. */
select * from Employees_Subquery where Department = ( select Department from Employees_Subquery where emp_name = 'Amit')


/* Find employees managed by Suresh. */
select * from Employees_Subquery where Manager_ID = ( Select emp_id from employees_Subquery where emp_name = 'Suresh')


/* Find departments whose average salary is greater than 75,000. */
select Department , avg(salary) "Avg Salary" from employees_subquery group by Department having AVG(salary) > (select 75000);


/* Find employees whose salary equals the maximum salary.  */
select * from employees_Subquery where salary = ( select MAX(salary) from employees_Subquery );


/* Find employees who earn more than Raj. */
select * from employees_Subquery where salary > ( select salary from employees_Subquery where emp_name = 'Raj') order by salary desc;


/* Medium */
/* Find employees earning more than the average salary of their department. */
select * from employees_subquery e where salary > ( select AVG(salary) from Employees_Subquery where Department = e.department )

/* Find employees earning the highest salary in each department. */
select * from Employees_Subquery e where salary = ( select MAX(salary) from Employees_Subquery where Department = e.department);


/* Find employees earning the second-highest salary in each department. */
select * from ( select * , DENSE_RANK() over( partition by Department order by salary desc) "Highest Salary" from Employees_Subquery ) t where "Highest Salary" = 2;

select * from Employees_Subquery

/* Find employees whose manager earns more than 130,000. */
select * from Employees_Subquery where Manager_ID in ( select Emp_ID from Employees_Subquery where Salary > 130000);

select * from Employees_Subquery where Emp_ID in (120,130);

/* Find departments having more employees than HR. */
select Department ,COUNT(*) "Total Employees" from Employees_Subquery group by Department having COUNT(*) > (select COUNT(*) from Employees_Subquery where Department = 'HR');


/* Find employees who are not managers. */
select * from Employees_Subquery where Emp_ID <> Manager_ID;


/* Find employees whose salary is greater than all HR employees. */
select * from Employees_Subquery where Salary > all ( select salary from employees_subquery where department = 'HR');


/* Find employees whose salary is less than any IT employee. */
select * from Employees_Subquery where Salary < Any ( select salary from employees_subquery where department = 'IT');


/* Find departments where the maximum salary exceeds 100,000. */

select Distinct Department from employees_Subquery where department in (select Department from Employees_Subquery group by Department having max(Salary) > 100000);


/* Find employees working under the manager with the most subordinates. */
select Top 1 Manager_ID from Employees_Subquery where Manager_ID is not null group by Manager_ID order by COUNT(*) desc;


/* Hard */
select * from Employees_Subquery;

/* Find employees earning above their manager's salary. */
select * from Employees_Subquery e where  Salary > ( select Salary from Employees_Subquery m where m.Emp_ID = e.Manager_ID);


/* Find departments with the highest average salary. */
Select Department , AVG(salary) "Highest Salary" from employees_subquery group by Department having AVG(salary) >= all (select avg(salary) from Employees_Subquery group by Department); 


/* Find employees who earn more than every employee in Sales. */
select * from Employees_Subquery where Salary > all ( select salary from Employees_Subquery where Department = 'sales');


/* Find employees whose salary is among the top 3 salaries company-wide. */
select * from Employees_Subquery where Salary in ( select distinct top 3 salary from Employees_Subquery order by salary desc );


/* Find employees belonging to departments whose average salary is above company average. */
select * from Employees_Subquery where Department in ( select Department from Employees_Subquery group by Department having avg(salary) > ( select AVG(salary) from Employees_Subquery));

/* Find managers managing employees from only one department. */
select * from Employees_Subquery where Emp_ID in ( select Manager_ID from Employees_Subquery where Manager_ID is not null group by Manager_ID having COUNT( distinct Department) = 1);


/* Find employees whose salary is greater than their department average but less than company average. */
select * from Employees_Subquery e where Salary > ( select AVG(salary) from Employees_Subquery where Department = e.department) and Salary < (select AVG(salary) from Employees_Subquery);

/* Find departments where no employee earns below 50,000. */
select distinct Department from Employees_Subquery where Department not in( select Department from Employees_Subquery where Salary < 50000);

/* Find employees whose salary is the third-highest in their department. */
select * from Employees_Subquery e where Salary = ( select MIN(salary)  from ( select distinct top 3 Salary from Employees_Subquery where Department = e.Department order by Salary desc )t);

select Department,salary from Employees_Subquery order by Department;
