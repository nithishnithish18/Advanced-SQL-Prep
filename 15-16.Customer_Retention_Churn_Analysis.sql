create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
delete from transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150);

select * from transactions

-- Solution using Self Join
 
--customer retention

select
month(this_month.order_date) as month,
count(distinct last_month.cust_id) as retained_customers
from transactions this_month left join transactions last_month 
on this_month.cust_id  = last_month.cust_id 
and datediff(month,last_month.order_date,this_month.order_date) = 1
group by month(this_month.order_date)


--customer churn
select
month(last_month.order_date) as month,
count(distinct last_month.cust_id) 
from transactions last_month left join transactions this_month 
on this_month.cust_id  = last_month.cust_id 
and datediff(month,last_month.order_date,this_month.order_date) =1
where  this_month.cust_id is null
group by month(last_month.order_date)


-- my solution using Lead and Lag
--customer retention
with cte as
(
select
*,
lead(order_date,1) over(partition by cust_id order by order_date desc) as last_date
from transactions
)
select month(order_date) as month,count(last_date) as retained_customers from cte group by month(order_date)



-- cutomer churn
with cte1 as (
select  *, lag(order_date,1) over(partition by cust_id order by order_date desc) as d
from transactions
)
select month(order_date) as month, count(distinct cust_id) as churn_customers from cte1  where d is null group by month(order_date)
select * from cte1