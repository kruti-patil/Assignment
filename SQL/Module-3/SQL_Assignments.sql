create database my_company_db;
use my_company_db;

create table salesman(
	salesman_id int primary key,
    sal_name varchar(255),
    city varchar(200),
    commission decimal(10,6)
);
create table customer (
		customer_id int primary key,
        cust_name varchar(255),
		city varchar(200),
        grade int,
	   salesman_id  int references salesman(salesman_id)
);

create table orders(
		ord_no int primary key,
        purch_amt decimal(10,2),
        ord_date DATE,
		customer_id INT REFERENCES customer(customer_id),
        salesman_id INT REFERENCES salesman(salesman_id)
);

create table item_mast(
	pro_id int primary key ,
	pro_name varchar(100),
    pro_price decimal(10,2),
    pr_com  int
);

/*insert Recod Table*/

insert into salesman values(5001,"James Hoog","New York",0.15),
						   (5002,"Nail Knite","Paris",0.13),
						   (5005,"Pit Alex","London",0.11),
                           (5006,"Mc Lyon","Paris",0.14),
                           (5007,"Paul Adam","Rome",0.13),
                           (5003,"Lauson Hen","San Jose",0.12);
select * from salesman;
insert into customer values(3002,'Nick Rimando','New York',100,5001),
						   (3007,'Brad Davis','New York',200,5001),
                           (3005,'Graham Zusi','California',200,5002),
						   (3008,'Julian Green','London',300,5002),
						   (3004,'Fabian Johnson','Paris',300,5006),
						   (3009,'Geoff Cameron','Berlin',100,5003),
						   (3003,'Jozy Altidor','Moscow',200,5007),
                           (3001,'Brad Guzan','London',null,5005);
select * from customer;

insert into orders values(7001,150.5,'2012-10-05',3005,5002),
						 (7009,270.65,'2012-09-10',3001,5005),
                         (7002,65.26,'2012-10-05',3002,5001),
						 (7004,110.5,'2012-08-17',3009,5003),
                         (7007,948.5,'2012-09-10',3005,5002),
						 (7005,2400.6,'2012-07-27',3007,5001),
                         (7008,5760,'2012-09-10',3002,5001),
                         (70010,1983.43,'2012-10-10',3004,5006),
                         (70003,2480.4,'2012-10-10',3009,5003),
						 (70012,250.45,'2012-06-27',3008,5002),
						 (70011,75.29,'2012-08-17',3003,5007),
                         (70013,3045.6,'2012-04-25',3002,500);
select * from orders;    

insert into item_mast values(101, 'Motherboard', 3200.00, 15),
							(102, 'Keyboard', 450.00, 16),
							(103, 'ZIP drive', 250.00, 14),
							(104, 'Speaker', 550.00, 16),
							(105, 'Monitor', 5000.00, 11),
							(106, 'DVD drive', 900.00, 12),
							(107, 'CD drive', 800.00, 12),
							(108, 'Printer', 2600.00, 13),
							(109, 'Refill cartridge', 350.00, 13),
							(110, 'Mouse', 250.00, 12);
	select * from item_mast;

/*1. write a SQL query to find customers who are either from the city 'New York' or who do not have a grade greater than 100. Return customer_id, cust_name, city,
 grade, and salesman_id.*/    
 
 select * from customer 
 where city='New York' 
 and grade <= 100 
 and grade IS Not NULL;
 
 /* 2. write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id.
 */
 
 select * from customer 
 where city='New York' 
 and grade >100 
 and grade IS Not NULL;
 
 /*3. Write a SQL query that displays order number, purchase amount, and the achieved and unachieved percentage (%) for those orders that exceed 50% of the
 target value of 6000.*/
 
 select 
	 ord_no,
	 purch_amt,
	 (purch_amt/6000)*100 as achieved_percentage,
	 (100-(purch_amt/6000)* 100) as unachieved_percentage
 from
	orders
where
	purch_amt > (6000 * 0.50);

/* 4. write a SQL query to calculate the total purchase amount of all orders. Return
 total purchase amount.*/
 
/* select 
	ord_no,
	sum(purch_amt) as total_purchase_amount
from 
	orders
group by
	ord_no;*/
select 
	sum(purch_amt) as total_purchase_amount
from
	orders;

/*5. write a SQL query to find the highest purchase amount ordered by each customer.
 Return customer ID, maximum purchase amount*/
 
 select 
		customer_id,
        max(purch_amt) as maximum_purchase_amount
from
		orders
group by 
		customer_id;

/*6. write a SQL query to calculate the average product price. Return average product
 price*/

 select 
		avg(pro_price) as 'Average_product_Price'
from
		item_mast;

 /*7. write a SQL query to find those employees whose department is located at
 ‘Toronto’. Return first name, last name, employee ID, job ID.*/

 select 
		emp.employee_id as 'employee_id',
        emp.first_name as 'First Name',
        emp.last_name as 'Last Name',
        emp.job_id as 'Job Id'
from
	employees as emp
left join 
		departments as dept
on 
	emp.department_id = dept.department_id
left join
		locations as loc
on 
	dept.location_id = loc.location_id
where
		loc.city = 'Toronto';

/* 8. write a SQL query to find those employees whose salary is lower than that of
 employees whose job title is "MK_MAN". Exclude employees of the Job title
 ‘MK_MAN’. Return employee ID, first name, last name, job ID*/
 
 select 
		employee_id as 'employee_id',
        first_name as 'First Name',
        last_name as 'Last Name',
        job_id as 'Job Id',
        min(salary) as 'Minimum_Salary'
from
	employees
where 
		job_id = 'MK_MAN'
group by 
		employee_id,
        first_name,
        last_name,
        job_id 
order by
		Minimum_Salary;
        
/* 9. write a SQL query to find all those employees who work in department ID 80 or
 40. Return first name, last name, department number and department name.*/
 
 select 
        emp.first_name as 'First Name',
        emp.last_name as 'Last Name',
       dept.department_id as 'department_Number',
       dept.department_name as 'Department_Name'
from 
		employees as emp
join 
		departments as dept
on 
		emp.department_id = dept.department_id
where
		emp.department_id in(80,40);

/* 10.write a SQL query to calculate the average salary, the number of employees
 receiving commissions in that department. Return department name, average
 salary and number of employees.*/
 
	select 
			dept.department_name,
            avg(e.salary) as 'average_salary',
            count(commission_pct) as 'count_of_commission'
	from
			employees as e
	left join
			departments as dept
	on
		e.department_id = dept.department_id
	group by
			dept.department_name;
	
 
/* 11.write a SQL query to find out which employees have the same designation as the
 employee whose ID is 169. Return first name, last name, department ID and job
 ID*/
    
select
		emp.first_name as 'First Name',
        emp.last_name as 'Last Name',
        dept.department_id as 'department_Number',
        job_id as 'Job Id'
from 
		employees as emp
join 
		departments as dept
on
		emp.department_id = dept.department_id
where
		emp.job_id = (
        SELECT job_id
        FROM employees
        WHERE employee_id = 169
    );
   
  /* 12.write a SQL query to find those employees who earn more than the average salary.
 Return employee ID, first name, last name.*/
 
 select
		employee_id,
        first_name,
        last_name,
        salary
from
		employees
where
		salary > (
				SELECT AVG(salary)
				FROM employees
			);

/* 13.write a SQL query to find all those employees who work in the Finance
 department. Return department ID, name (first), job ID and department name.*/
 
 select 
		 dept.department_id as 'Department_Id',
         dept.department_name as 'Department Name',
		emp.first_name  as 'First Name',
        job_id as 'Job Id'
from 
		employees as emp
join
		departments as dept
on 
	emp.department_id = dept.department_id
where
		dept.department_name = 'Finance';

/*14. From the following table, write a SQL query to find the employees who earn less
 than the employee of ID 182. Return first name, last name and salary.*/
 
 select
        first_name,
        last_name,
        salary
from
	 employees 
where
	salary < (
    SELECT salary
    FROM employees
    WHERE employee_id = 182
) and employee_id != 182;

/* 15.Create a stored procedure CountEmployeesByDept that returns the number of
 employees in each department*/
 
 delimiter $$
 create procedure CountEmployeesByDept()
 begin
		select 
			dept.department_id as 'Department_Id',
			dept.department_name as 'Department Name',
            count(emp.employee_id) as 'Number_Of_Employees'
		from
				employees as emp
		left join
				departments as dept
		on
				emp.department_id = dept.department_id
		group by
				dept.department_id,
				dept.department_name 
		order by
					Number_Of_Employees;
end $$
delimiter ;
   /* Call procedure CountEmployeesByDept*/     
call CountEmployeesByDept();

/* 16.Create a stored procedure AddNewEmployee that adds a new employee to the
 database.*/

delimiter $$
create procedure AddNewEmployee(
	in p_employee_id int,
    in p_first_name varchar(20),
    in p_last_name varchar(20),
	in p_email varchar(25),
	in p_phone_number varchar(20),
    in p_hire_date DATE,
    in p_job_id varchar(20),
    in p_salary decimal(8,2),
    in p_commission_pct DECIMAL(2, 2),
    in p_manager_id int,
    in p_department_id int
)
begin
		insert into employees
					(
						employee_id,
						first_name,
						last_name,
						email,
						phone_number,
						hire_date,
						job_id,
                        salary,
						commission_pct,
						manager_id,
						department_id
                    )
				values(
					p_employee_id,
                    p_first_name,
                    p_last_name,
                    p_email,
                    p_phone_number,
                    p_hire_date,
                    p_job_id,
                    p_salary,
                    p_commission_pct,
                    p_manager_id,
                    p_department_id
                );
end $$
delimiter ;
	
call AddNewEmployee(98,
	'John',
	'King',
	'SKING',
	'515.123.4567',
	STR_TO_DATE('17-JUN-1987', '%d-%M-%Y'),
	'AD_PRES',
	24000,
	NULL,
	NULL,
	10);
select * from employees;

/*17.Create a stored procedure DeleteEmployeesByDept that removes all employees
 from a specific department */

delimiter $$
create procedure DeleteEmployeesByDept(in p_department int)
begin
		    START TRANSACTION;
		UPDATE employees
		SET manager_id = NULL
		WHERE manager_id IN (
			SELECT manager_employee_id
			FROM (
					select employee_id as manager_employee_id
                    from employees
					WHERE department_id = p_department 
				) as temp_managers
		);

			UPDATE departments
			SET manager_id = NULL
			WHERE manager_id IN (
			SELECT manager_employee_id
			FROM (
				SELECT employee_id AS manager_employee_id
				FROM employees
				WHERE department_id = p_department
			) AS temp_managers2
		);

		DELETE FROM job_history
		WHERE employee_id IN (
			SELECT employee_id
			FROM employees
			WHERE department_id = p_department
		)
        or 
		department_id = p_department;
		delete from employees
        where department_id = p_department;
        delete from departments
        where department_id = p_department;	
        delete from job_history
		where department_id = p_department;	
	commit ;
end $$
delimiter ;
call DeleteEmployeesByDept(110);
drop  procedure DeleteEmployeesByDept;
	
/*18.Create a stored procedure GetTopPaidEmployees that retrieves the highest-paid
 employee in each department.*/
 
 delimiter $$
 
 create procedure GetTopPaidEmployees()
 begin
		select 
				e.employee_id,
                e.first_name,
                e.last_name,
                e.email,
                e.phone_number,
                e.hire_date,
                e.salary,
                dept.department_name
		from
				employees as e
		left join 
					departments as dept
		on 
			e.department_id = dept.department_id
		where 
			(e.department_id, e.salary) IN (
				select department_id, MAX(salary)
				from employees
				group by department_id
			)	
		
		order by
				dept.department_name;
end $$
delimiter ;
call GetTopPaidEmployees();
/*drop procedure  GetTopPaidEmployees;*/

/*19.Create a stored procedure PromoteEmployee that increases an employee’s salary
 and changes their job role*/
 
 delimiter $$
 create procedure PromoteEmployee(
									in p_employee_id int,
                                    in p_salary decimal(8,2),
                                    in p_job_id varchar(20)
								)
begin
		update 
				employees
		set
				salary = p_salary,
                job_id = p_job_id
		where
				employee_id = p_employee_id;
		select * from employees;
end $$
delimiter ;
-- drop procedure PromoteEmployee;
call PromoteEmployee(98,77000.00,'PU_MAN');

 /*20.Create a stored procedure AssignManagerToDepartment that assigns a new
 manager to all employees in a specific department. */

delimiter $$
create procedure AssignManagerToDepartment(
											in p_manager_id int,
											in p_department_id int		
										  )
begin
		update
				employees
		set
			manager_id = p_manager_id
		where
		   department_id = p_department_id;
		--  Display all employee records after update
		select * from employees ;
end $$

  delimiter ;
  
  call AssignManagerToDepartment(205, 10);
-- drop procedure AssignManagerToDepartment;
	