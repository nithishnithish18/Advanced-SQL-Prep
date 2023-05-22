create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');


--SQL question where we need to rank only the duplicate records and unique records should have null values.
--Method =  "Split and provide rank for id's having count(id) > 1 later join with master table"


with cte1 as(
select 
id 
from list group by id having count(id)>1
),

cte2 as (
select *,
rank() over(order by id) as rnk from cte1
)

select 
a.id,
"DUP"+cast(rnk  as varchar(2)) as Output
from list a left join cte2 b on a.id = b.id