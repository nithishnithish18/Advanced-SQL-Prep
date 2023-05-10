create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

/*
problem statement

find how many products fall into customer_budget along with products list 
incase of class chose the less costiliest products
*/

-- Calculate running sum for the products

with r_cte as( 
select *,sum(cost) over(order by cost) as rcost from products
)

-- left join running sum with customer_budget table to fetch list of less costlier products falling into budget

select 
customer_id,
budget,
count(1) as no_of_product,
string_agg(product_id,",") as list_of_products
from customer_budget cb left join r_cte rc on rc.rcost < cb.budget
group by customer_id,budget
