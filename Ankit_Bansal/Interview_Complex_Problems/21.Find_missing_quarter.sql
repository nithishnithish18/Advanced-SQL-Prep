CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);


--method1 - complex aggregation

select Store,'Q' + cast(10 - sum(cast(right(Quarter,1) as int)) as char)as missing_quarter from STORES
group by Store

--method2 - recursive cte

with cte as (
select distinct store, 1 as "q_no" from STORES
union all
select store, q_no + 1 as q_no from cte
where q_no < 4 
),
cte2 as (
select store,"Q" + cast(q_no as char(2)) as q_no from cte
)

select 
a.*
from cte2 a left join STORES b  
on a.store = b.store and a.q_no = b.Quarter
where b.store is null
order by a.store
option (maxrecursion 10);


--method3 - cross join

with cte as (
select distinct a.store,b.Quarter as q from STORES a,STORES b 
)

select a.store,a.q
from cte a left join STORES b on a.store = b.store and a.q = b.Quarter
where b.store is null


