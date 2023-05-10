create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');


--find on and off time of a event
--use running sum trick to create group key

with cte as (select 
cast(concat(substring(event_time,1,2),substring(event_time,4,2)) as int) as event_time,
status,
lag(status,1,status) over(order by event_time asc)as prev_status
from event_status)

select
min(event_time)
sum(
case when status = "on" and prev_status="off" then 1 else 0 end ) over(order by event_time asc) as  g_key

from cte