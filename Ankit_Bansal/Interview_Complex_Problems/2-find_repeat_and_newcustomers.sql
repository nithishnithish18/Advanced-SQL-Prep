create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),
(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),
(6,500,cast('2022-01-02' as date),2700),(7,100,cast('2022-01-03' as date),3000),
(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


with visit_date as(
select
  customer_id,min(order_date) as first_visit_date
from 
  customer_orders group by customer_id
),

final_cte as(
select
  co.*,
  fv.first_visit_date,
  case 
    when co.order_date = fv.first_visit_date then 1 else 0 end as first_visit_flag,
  case
    when co.order_date!=fv.first_visit_date then 1 else 0 end as repeat_flag,
  case 
	when co.order_date = fv.first_visit_date then co.order_amount else 0 end as fv_amount,
  case 
	when co.order_date != fv.first_visit_date then co.order_amount else 0 end as rp_amount 
from 
  customer_orders co 
inner join
  visit_date fv
on 
  co.customer_id = fv.customer_id
)

select order_date,sum(first_visit_flag) as new_customers,
sum(repeat_flag) as repeat_customers,
sum(fv_amount) as fv_purchase_amount,
sum(rp_amount) as repeat_purchase_amount
from final_cte group by order_date

