create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));

insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

-- self join method without row_number() function

with cte1 as
(select a.id, a.start_time, b.end_time
from drivers a left join drivers b on a.id = b.id
and a.end_loc = b.start_loc and a.end_time = b.start_time
)
select id, count(start_time) as total_rides, count(end_time) as profit_rides
from cte1
group by 1


-- using window function
with cte as(
select *,lead(start_loc,1) over(partition by id order by start_time asc) as nex_start_loc
from drivers
)

select id,count(*) as total_rides, sum(case
when end_loc = nex_start_loc then 1 else 0 
end) as profit_rides
from cte
group by 1

-- using self join with row function
with rides as 
(
select *,row_number() over(partition by id order by start_time asc) as rn
from drivers
)
select a.*,b.* from rides a left join rides b on a.end_loc = b.start_loc and a.id = b.id and a.rn+1 = b.rn

