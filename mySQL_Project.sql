create database My_Project;
use My_Project;

-- Part 1: Banking Tables(Create Bank_Customers table)
create table Bank_Customers(customer_id int primary key auto_increment, customer_name varchar(25) not null, 
							city varchar(25) not null);
desc Bank_Customers;

-- Create Bank_Accounts table with Foreign Key linking to Bank_Customers
create table Bank_Accounts(account_id int primary key auto_increment, customer_id int not null, 
							account_type varchar(20) not null, balance decimal(10,2) not null default 0, 
                            foreign key (customer_id) references Bank_Customers(customer_id), 
                            check (balance >= 0), check (account_type in ('Savings','Current')) );
                            
desc Bank_Accounts;                           

-- Insert sample records into Bank_Customers table                      
insert into Bank_Customers(customer_name, city) values('Ramu','Chennai'),('Sowmya','Banglore'),('kiran','Hyderabad'),
													('Divya','Vijayawada'),('Harish','Chennai'),('Meena','Tirupati'); 
select * from Bank_Customers;

-- Insert sample records into Bank_Accounts table
insert into Bank_Accounts(customer_id, account_type, balance) values(1,'Savings',45000),(1,'Current',25000),(2,'Savings',35000),
					(3,'Current',18000),(4,'Savings',55000),(5,'Savings',12000),(6,'Current',40000),(2,'Savings',15000),
                    (3,'Savings',28000),(4,'Current',32000);       
select * from Bank_Accounts;

-- BANKING SCENARIO – QUESTIONS
-- Basic + WHERE + Operators (1–15)
-- 1. Retrieve all accounts with balance greater than 20,000.
select * from Bank_Accounts where balance > 20000;

-- 2. Find customers who live in Chennai.
select * from Bank_Customers where city = 'Chennai';

-- 3. Display accounts with balance between 20,000 and 50,000.
select * from Bank_Accounts where balance between 20000 and 50000;

-- 4. Find customers whose names start with 'J'.
select * from Bank_Customers where customer_name like 'J%';

-- 5. Retrieve accounts of type 'Savings' or 'Current'.
select * from Bank_Accounts where account_type in('Savings', 'Current');

-- 6. Display accounts that are not 'Savings'.
select * from Bank_Accounts where account_type <> 'Savings';

-- 7. Find customers whose names contain the letter 'a'.
select * from Bank_Customers where customer_name like '%a%';

-- 8. Retrieve accounts with balance less than or equal to 30,000.
select * from Bank_Accounts where balance <=30000;

-- 9. Find customers who are not from Madurai.
select * from Bank_Customers where city <> 'Madurai';

-- 10. Display accounts where balance is not between 10,000 and 40,000.
select * from Bank_Accounts where balance not between 10000 and 40000;

-- 11. Retrieve customers whose names end with 'i'.
select * from Bank_Customers where customer_name like '%i';

-- 12. Find accounts with balance equal to 50,000.
select * from Bank_Accounts where balance = 50000;

-- 13. Display customers whose city is either Chennai or Salem.
select * from Bank_Customers where city in ('Chennai' ,'Salem');

-- 14. Find accounts with balance greater than 10,000 and less than 40,000.
select * from Bank_Accounts where balance > 10000 and balance < 40000;

-- 15. Retrieve accounts where account type is not in ('Current').
select * from Bank_Accounts where account_type not in('Current');

-- ORDER BY (16–18)
-- 16. Display all accounts sorted by balance in descending order.
select * from Bank_Accounts order by balance desc;

-- 17. List customers sorted alphabetically by name.
select * from Bank_Customers order by customer_name asc;

-- 18. Display accounts sorted by account type and then by balance (descending)
select * from Bank_Accounts order by account_type asc, balance desc;

-- Aggregate Functions (19–23)
-- 19. Find the total balance of all accounts.
select sum(balance) as total_balance from Bank_Accounts;

-- 20. Calculate the average balance of accounts.
select avg(balance) as average_balance from Bank_Accounts;

-- 21. Find the maximum account balance.
select max(balance) as maximum_balance from Bank_Accounts;

-- 22. Find the minimum account balance.
select min(balance) as minimum_balance from Bank_Accounts;

-- 23. Count the total number of customers.
select count(*) as total_customer from Bank_Customers;

-- GROUP BY + HAVING (24–28)
-- 24. Find total balance grouped by account type.
select account_type, sum(balance) as total_balance from Bank_Accounts group by account_type;

-- 25. Find average balance for each account type.
select account_type, avg(balance) as average_balance from Bank_Accounts group by account_type;

-- 26. Display account types having average balance greater than 20,000.
select account_type, avg(balance) as average_balance from Bank_Accounts group by account_type having average_balance > 20000;

-- 27. Count number of accounts for each customer.
select customer_id, count(*) as total_accounts from Bank_Accounts group by customer_id;

-- 28. Display customers having more than one account.
select customer_id, count(*) as total_accounts from Bank_Accounts group by customer_id having count(*)>1;

-- JOINS (29–35)
-- 29. Retrieve customer names along with their account balances.
select c.customer_name, a.balance from Bank_Customers c join Bank_Accounts a on c.customer_id = a.customer_id;

-- 30. Display all customers and their accounts (including customers without accounts).
select c.customer_id, c.customer_name, a.account_id, a.account_type, a.balance from Bank_Customers c left join Bank_Accounts a
						on c.customer_id = a.customer_id;
                        
-- 31. Display all accounts and corresponding customer details.
select a.account_id, a.account_type, a.balance, c.customer_name, c.city from Bank_Accounts a join Bank_Customers c 
						on a.customer_id = c.customer_id;
                        
-- 32. Retrieve customer names and account types where balance is greater than 20,000.
select c.customer_name, a.account_type, a.balance from Bank_customers c join Bank_Accounts a
		on c.customer_id = a.customer_id where a.balance >20000; 
        
-- 33. List customers with their total balance using JOIN.
select  c.customer_id, c.customer_name, sum(a.balance) as total_balance from Bank_Customers c join Bank_Accounts a 
		on c.customer_id = a.customer_id group by c.customer_id, c.customer_name;
        
-- 34. Display customer names and balances sorted by balance.
select c.customer_name, a.balance from Bank_Customers c join Bank_Accounts a on c.customer_id = a.customer_id 
		order by a.balance asc;
        
-- 35. Count number of accounts for each city using JOIN.       
select c.city, count(a.account_id) from Bank_Customers c join Bank_Accounts a on c.customer_id = a.customer_id
		group by c.city;
        
-- SUBQUERIES (36–40)
-- 36. Find accounts with balance greater than average balance.
select * from Bank_Accounts where balance >(select avg(balance) from Bank_Accounts);

-- 37. Retrieve customers who have accounts.
select * from Bank_Customers where customer_id in (select customer_id from Bank_Accounts );

-- 38. Find customers who do not have any accounts.
select * from Bank_Customers where customer_id not in (select customer_id from Bank_Accounts);

-- 39. Display account(s) with the maximum balance.
select * from Bank_Accounts where balance = (select max(balance) from Bank_Accounts);

-- 40. Find customers whose total balance is greater than 40,000.
select c.customer_id, c.customer_name, sum(a.balance) as total_balance from Bank_customers c join Bank_Accounts a on
		c.customer_id = a.customer_id group by c.customer_id, c.customer_name having sum(a.balance) > 40000;
                        
                            
-- Part 2: Railway tables(Create Trains table)
create table Trains(train_id int primary key auto_increment, train_name varchar(25) not null, source varchar(25) not null,
					destination varchar(25) not null);
desc Trains;

-- Create Bookings table with Foreign Key linking to Trains
create table Bookings(booking_id int primary key auto_increment, train_id int not null, passenger_name varchar(25) not null,
					fare decimal(10,2) not null, status varchar(25) not null, foreign key(train_id) references Trains(train_id), 
                        check (fare >=0), check (status in ('Confirmed','Waiting','Cancelled')) );                    
desc Bookings;

-- Insert sample records into Trains table
insert into Trains(train_name, source, destination) values('Chennai Express','Chennai','Madurai'),
				('Coastal Express','Vijayawada','Visakhapatnam'),('Raylaseema Express','Tirupati','Banglore'),
                ('City Express','Hyderabad','Chennai');
select * from Trains;

-- Insert sample records into Bookings table
insert into Bookings(train_id, passenger_name, fare, status) values(1,'Ramya',500,'Confirmed'),(1,'Sowmya',500,'Waiting'),
					(2,'Kiran',350,'Confirmed'),(3,'Divya',450,'Cancelled'),(2,'Harish',350,'Confirmed'),
                    (4,'Meena',600,'Confirmed'),(3,'Arun',450,'Waiting');
select * from Bookings;

-- RAILWAY RESERVATION – QUESTIONS
-- Basic + WHERE + Operators (41–45)
-- 41. Retrieve all bookings with fare greater than 400.
select * from Bookings where fare >400;

-- 42. Find bookings where status is not 'Confirmed'.
select * from Bookings where status <> 'Confirmed';

-- 43. Display trains starting from Chennai.
select * from Trains where source ='Chennai';

-- 44. Retrieve bookings with fare between 300 and 500.
select * from Bookings where fare between 300 and 500;

-- 45. Find passengers whose names start with 'A'.
select * from Bookings where passenger_name like 'A%';

-- JOINS + GROUP BY + ORDER BY (46–48)
-- 46. Retrieve train names along with passenger names.
select t.train_name, b.passenger_name from Trains t join Bookings b on t.train_id = b.train_id;

-- 47. Count number of bookings for each train.
select t.train_id, t.train_name, count(b.booking_id) as total_booking from Trains t left join Bookings b on 
		t.train_id = b.train_id group by t.train_id, t.train_name;

-- 48. Display train names and total fare collected for each train.
select t.train_name, sum(b.fare) as total_fare from Trains t left join Bookings b on t.train_id = b.train_id group by
		t.train_id, t.train_name;

-- SUBQUERIES (49–50)
-- 49. Find bookings with fare equal to the highest fare.
select * from Bookings where fare = (select max(fare) from Bookings );

-- 50. Retrieve trains that have more than one booking.
select t.train_id, t.train_name, count(b.booking_id) as total_bookings from Trains t join Bookings b on 
		t.train_id = b.train_id group by t.train_id, t.train_name having count(b.booking_id)>1;


-- Part 3: Employee table(Create Employee table)
create table Employee(emp_id int primary key, emp_name varchar(25) not null, department varchar(30) not null, 
		salary decimal(10,2) not null, city varchar(30) not null, joining_date date not null, check (salary >=0));
desc Employee; 

-- Insert sample records into Employee table
insert into Employee values (101,'Ramu','IT',62000,'Chennai','2022-01-15'),(102,'Sowmya','HR',46000,'banglore','2021-03-10'),
							(103,'kiran','IT',72000,'Chennai','2020-07-12'),(104,'Divya','Finance',56000,'Mumbai','2023-01-20'),
                            (105,'Harish','HR',49000,'Delhi','2022-05-05'),(106,'Meena','Finance',66000,'Mumbai','2021-08-18'),
                            (107,'Arun','IT',58000,'Hyderabad','2024-02-01'),(108,'Priya','Sales',52000,'Tirupati','2023-06-12');
select * from Employee;
      
-- Employee Table
-- 1. Find the total number of employees in each department.
select department, count(*) as total_employee from Employee group by department;

-- 2. Find the average salary of employees in each department.
select department, avg(salary) as average_salary from Employee group by department;

-- 3. Display departments having more than one employee.
select department, count(*) as total_employee from Employee group by department having count(*) > 1;

-- 4. Find the highest salary in each department.
select department, max(salary) as maximum_salary from Employee group by department;

-- 5. Find the lowest salary in each department.
select department, min(salary) as minimum_salary from Employee group by department;

-- 6. Find departments whose average salary is greater than 50,000.
select department, avg(salary) as average_salary from Employee group by department having avg(salary) > 50000;

-- 7. Calculate the total salary expenditure for each department.
select department, sum(salary) as total_salary from Employee group by department;

-- 8. Display all employees sorted by salary in descending order.
select * from Employee order by salary desc;

-- 9. Display employees sorted first by department and then by salary in descending order.
select * from Employee order by department asc, salary desc;

-- 10. Find cities that have more than one employee.
select city, count(*) as total_employees from Employee group by city having count(*) > 1;

-- 11. Find the total salary paid in each city.
select city, sum(salary) as total_salary from Employee group by city;

-- 12. Display departments ordered by total salary expenditure from highest to lowest.
select department, sum(salary) as total_salary from Employee group by department order by total_salary desc;

-- 13. Find the number of employees in each department whose salary is greater than 50,000.
select department, count(*) as total_employees from Employee where salary> 50000 group by department;

-- 14. Find the difference between the highest and lowest salary in each department.
select department, max(salary) - min(salary) as salary_difference from Employee group by department;

-- 15. Display the top 3 highest-paid employees.
select * from Employee order by salary desc limit 3;
      
      
-- Part 4: Sales customers and orders(Create Sales_Customers table)
create table Sales_Customers(customer_id int primary key, customer_name varchar(25) not null, city varchar(30) not null);
desc Sales_Customers;

-- Create Orders table with Foreign Key linking to Orders
create table Orders(order_id int primary key, customer_id int not null, amount decimal(10,2) not null, order_date date not null,
					foreign key(customer_id) references Sales_Customers(customer_id), check (amount >=0));
desc Orders;

-- Insert sample records into Sales_Customer table
insert into Sales_Customers values(1,'Ramu','Chennai'),(2,'Sowmya','Banglore'),(3,'Kiran','Hyderabad'),
								  (4,'Divya','vijayawada'),(5,'Harish','Tirupati'),(6,'Meena','Mumbai');

select * from Sales_Customers;

-- Insert sample records into Orders table
insert into Orders values(1001,1,3000,'2026-01-10'),(1002, 1, 2500, '2026-02-12'),(1003, 1, 4000, '2026-03-15'),
							(1004, 1, 2000, '2026-04-18'),(1005, 2, 5000, '2026-01-11'),(1006, 2, 3500, '2026-02-20'),
                            (1007, 2, 2500, '2026-03-21'),(1008, 3, 7000, '2026-01-25'),(1009, 3, 4500, '2026-03-05'),
                            (1010, 4, 12000, '2026-02-14'),(1011, 5, 1500, '2026-01-30'),(1012, 5, 1800, '2026-02-28'),
                            (1013, 5, 2200, '2026-03-30'),(1014, 5, 3000, '2026-04-10'),(1015, 6, 2500, '2026-02-05'),
                            (1016, 6, 6000, '2026-04-12');
select * from Orders;

-- Customers & Orders Tables
-- 16. Find the total order amount for each customer.
select customer_id, sum(amount) from Orders group by customer_id;

-- 17. Find customers who have placed more than 3 orders.
select c.customer_id,c.customer_name,count(o.order_id) as total_orders from Sales_Customers c join Orders o on 
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name having count(o.order_id) > 3;

-- 18. Find the average order amount for each customer.
select c.customer_id, c.customer_name, avg(o.amount) as average_amount from Sales_Customers c join Orders o on 
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name;

-- 19. Find the highest order amount placed by each customer.
select c.customer_id, c.customer_name, max(o.amount) as maximum_amount from Sales_Customers c join Orders o on
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name;

-- 20. Display customers sorted by their total purchase amount.
select c.customer_id, c.customer_name, sum(o.amount) as total_purchase from Sales_Customers c join Orders o on
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name order by total_purchase desc;

-- 21. Find customers whose total purchase amount exceeds 10,000.
select c.customer_id, c.customer_name, sum(o.amount) as total_purchase from Sales_Customers c join Orders o on
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name having total_purchase > 10000;

-- 22. Display customer names along with the total number of orders placed.
select c.customer_name, count(o.order_id) as total_orders from Sales_Customers c join Orders o on 
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name;

-- 23. Find the customer who spent the highest amount.
select c.customer_id, c.customer_name, sum(o.amount) as total_spent from Sales_Customers c join Orders o on 
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name order by total_spent desc limit 1;

-- 24. Find the customer who placed the maximum number of orders.
select c.customer_id, c.customer_name, count(o.order_id) as total_orders from Sales_Customers c join Orders o on
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name order by total_orders desc limit 1;

-- 25. Find customers whose average order amount is greater than 2,000.
select c.customer_id, c.customer_name, avg(o.amount) as average_order_amount from Sales_Customers c join Orders o on
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name having average_order_amount > 2000;

-- 26. Display the top 5 customers based on total purcase amount.
select c.customer_id, c.customer_name, sum(o.amount) as total_purchase from Sales_Customers c join Orders o on
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name order by total_purchase desc limit 5;

-- 27. Find the minimum order amount for each customer.
select c.customer_id, c.customer_name, min(o.amount) as minimum_order from Sales_Customers c join Orders o on
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name;

-- 28. Find customers who have placed orders worth more than 5,000 in total.
select c.customer_id, c.customer_name, sum(o.amount) as total_purchase from Sales_Customers c join Orders o on 
		c.customer_id = o.customer_id group by c.customer_id, c.customer_name having total_purchase > 5000;

-- 29. Display customer-wise total orders and total purchase amount.
select c.customer_id, c.customer_name, count(o.order_id) as total_order, sum(o.amount) as total_purchase from Sales_Customers c 
		join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.customer_name;

-- 30. Find customers who placed more than 2 orders and spent more than 8,000.
select c.customer_id, c.customer_name, count(o.order_id) as total_order, sum(o.amount) as total_purchase from Sales_Customers c 
		join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.customer_name having total_order >2 and 
        total_purchase > 8000;


-- Part 5: Students(Create Students table)
create table Students(student_id int primary key, student_name varchar(25) not null, department varchar(30) not null, 
						marks int not null, check (marks between 0 and 100));
desc Students;

-- Insert sample records into Students table
insert into Students values(1,'Ramu','CSE',85),(2,'Sowmya','CSE',78),(3,'Kiran','CSE',92),(4,'Divya','CSE',88),
							(5,'Harish','CSE',76),(6,'Meena','CSE',81),(7,'Arun','ECE',72),(8,'priya','ECE',80),
                            (9,'vijay','ECE',68),(10,'Anu','ECE',75),(11,'Suresh','ECE',82),(12,'Geetha','ECE',77),
                            (13,'Manoj','Mech',65),(14,'Nisha','Mech',70),(15,'Pavan','Mech',74),(16,'Rahul','Mech',69),
                            (17,'Tara','Mech',80),(18,'Uma','Mech',73),(19,'Varun','Civil',91),(20,'Yamini','Civil',84),
                            (21,'Zoya','Civil',79),(22,'Bharat','Civil',88),(23,'Charu','Civil',72),(24,'Deepthi','Civil',95);
select * from Students;

-- Students Table
-- 31. Find the average marks scored by students in each department.
select department, avg(marks) as average_marks from Students group by department;

-- 32. Find departments whose average marks are above 75.
select department, avg(marks) as average_marks from Students group by department having average_marks>75;

-- 33. Find the highest mark scored in each department.
select department, max(marks) as maximum_marks from Students group by department;

-- 34. Find the total number of students in each department.
select department, count(*) as total_students from Students group by department;

-- 35. Find departments having more than 5 students.
select department, count(*) as total_student from Students group by department having total_student > 5;

-- 36. Display departments sorted by average marks in descending order.
select department, avg(marks) as average_marks from Students group by department order by average_marks desc;

-- 37. Find the top 3 departments based on average marks.
select department, avg(marks) as average_marks from Students group by department order by average_marks desc limit 3;

-- 38. Find departments whose average marks are between 70 and 90.
select department, avg(marks) as average_marks from Students group by department having average_marks between 70 and 90;

-- 39. Find the total marks scored by students in each department.
select department, sum(marks) as total_marks from Students group by department;

-- 40. Display departments sorted by the total number of students.
select department, count(*) as total_student from Students group by department order by total_student asc, department asc;

-- 41. Find the lowest mark scored in each department.
select department, min(marks) as minimum_marks from Students group by department;

-- 42. Find departments where the highest mark is greater than 90.
select department, max(marks) as maximum_marks from Students group by department having maximum_marks>90;

-- 43. Find the number of students scoring above 80 in each department.
select department, count(*) as total_students from Students where marks >80 group by department;

-- 44. Find departments where more than 3 students scored above 75.
select department, count(*) as total_students from Students where marks > 75 group by department having total_students >3;

-- 45. Display departments ordered by highest mark in descending order.
select department, max(marks) as maximum_marks from Students group by department order by maximum_marks desc;                    
