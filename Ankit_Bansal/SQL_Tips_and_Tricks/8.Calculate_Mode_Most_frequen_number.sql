create table mode 
(
id int
);

insert into mode values (1),(2),(2),(3),(3),(3),(3),(4),(5),(4),(4),(4);


--Calcualte MODE from the given table



--Method 1 - Using Subquery
with freq_cte as (
select id,count(1) as freq from mode group by id
)

select * from freq_cte where freq = (select MAX(freq) from freq_cte)


--Method 2 - Using Rank()
with freq_cte as (
select id,count(1) as freq from mode group by id
),
rank_cte as (
select *,rank() over(order by freq desc) as rn from freq_cte
)

select id,freq from rank_cte where rn=1
