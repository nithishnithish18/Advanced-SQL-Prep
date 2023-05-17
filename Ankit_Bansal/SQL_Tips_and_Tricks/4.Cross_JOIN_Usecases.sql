create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

create table colors (
color_id int,
color varchar(10)
);
insert into colors values (1,'Blue'),(2,'Green'),(3,'Orange');

create table sizes
(
size_id int,
size varchar(10)
);

insert into sizes values (1,'M'),(2,'L'),(3,'XL');

create table transactions
(
order_id int,
product_name varchar(10),
color varchar(10),
size varchar(10),
amount int
);
insert into transactions values (1,'A','Blue','L',300),(2,'B','Blue','XL',150),(3,'B','Green','L',250),(4,'C','Blue','L',250),
(5,'E','Green','L',270),(6,'D','Orange','L',200),(7,'D','Green','M',250);


--USECASES
--1. Create master data(ALL combinations of data)

--cross join cte
with master_data as (
select t.product_name,s.size,c.color from transactions t,sizes s, colors c
),
--another cte
cte as (
select product_name,color,size,sum(amount) as total_amount from transactions
group by product_name,color,size
)

--left join both the cte's
select m.product_name,m.size,m.color,c.total_amount from 
master_data m left join cte c on
m.product_name = c.product_name and m.color = c.color and m.size = c.size  


--2. Prepare huge data for performance testing
-- already know this


