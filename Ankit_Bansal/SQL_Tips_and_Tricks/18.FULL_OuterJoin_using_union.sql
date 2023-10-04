Create Table Customer (Customer_id int, customer_name Varchar(20))
Create Table Customer_order (Customer_id int, orderDate date)

Insert into Customer Values (1,'A')
Insert into Customer Values (2,'B')
Insert into Customer Values (3,'C')
Insert into Customer Values (4,'D')
Insert into Customer Values (5,'E')

Insert into Customer_order Values (1,'2022-01-05')
Insert into Customer_order Values (2,'2022-01-06')
Insert into Customer_order Values (3,'2022-01-07')
Insert into Customer_order Values (4,'2022-01-08')
Insert into Customer_order Values (6,'2022-01-09')

-- Full Outer Join method

select
a.Customer_id,
b.Customer_id
from Customer a
full outer join 
Customer_order b 
on a.Customer_id=b.Customer_id


-- Union method to perform Full outer join without join operation

select
a.Customer_id,b.Customer_id as b_Customer_id
from Customer a
left join 
Customer_order b 
on a.Customer_id=b.Customer_id
union all
select
b.Customer_id,a.Customer_id as Customer_id
from Customer_order a
left join 
Customer b 
on a.Customer_id=b.Customer_id
where b.Customer_id is null