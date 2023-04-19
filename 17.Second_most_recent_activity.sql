create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


-- select * from UserActivity


with cte as (
select
username,
activity,
startDate,
endDate,
count(1) over(partition by username) as total_count,
rank() over(partition by username order by startDate desc) as rn
from UserActivity
)

select username,activity,startDate,endDate from cte where total_count = 1 or rn = 2


