create table emp(
emp_id int,
emp_name varchar(10),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51);
-- (10, 'Rakesh',300,7000,6,50);


--Calcualte Mean age from the table


--Method 1 - Using Row_number()

with cte as (select 
*,
abs(Row_number() over(order by emp_age asc) - Row_number() over(order by emp_age desc)) as diff 
from emp)

select * from cte
where diff=1 or diff = 0