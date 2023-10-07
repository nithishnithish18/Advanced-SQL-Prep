

--Window function with aggregation
--Group by takes place first and aggregation happens next

select * from
(
select 
product,
category,
sum(sales) as total_sales,
rank() over(partition by category order by sum(sales) desc) as rn 
from table 
group by product,category
)A
where rn <= 5