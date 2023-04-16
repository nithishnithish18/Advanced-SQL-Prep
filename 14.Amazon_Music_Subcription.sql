create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));

-- select * from users
-- select * from events

--amazon music users subcribing to Prime within 30days after started using music app


with cte as(
select 
a.user_id,
a.type as type_a,
b.type as type_b,
b.access_date,
c.join_date,
case
  when datediff(day,c.join_date,b.access_date) < 30 then 1
  else 0 end as valid_y

from events a inner join events b on a.user_id = b.user_id
inner join users c  on a.user_id = c.user_id
where a.type = "Music" and b.type = "P" 
)

 
select count(a.user_id),1.0 * sum(b.valid_y) / count(a.user_id) * 100
from events a left join cte b on a.user_id = b.user_id
where a.type="Music" 
group by type



-- select * from cte





















