create table orders
(
order_id int,
customer_id int,
product_id int,
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

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


-- Lead and Lag method

with cte as (
select a.*,b.*,row_number() over(partition by order_id order by name) as rn from orders a  
left join products b on a.product_id = b.id
),

cte2 as (select *,case
when lead(name,1) over(partition by order_id order by name) is not null then concat(name,' ',lead(name,1) over(partition by order_id order by name)) 
when rn > 1 then concat(lag(name,rn-1) over(partition by order_id order by name),' ',name)
end as pair
from cte)


select pair, count(*) as purchase_freq from cte2
where pair is not null
group by pair
order by  pair


-- self join method


select p1.name+" "+p2.name as pair,count(*) as purchase_freq from orders o1
inner join orders o2 on o1.order_id = o2.order_id
inner join products p1 on o1.product_id = p1.id
inner join products p2 on o2.product_id = p2.id
where  o1.product_id < o2.product_id
group by p1.name+" "+p2.name