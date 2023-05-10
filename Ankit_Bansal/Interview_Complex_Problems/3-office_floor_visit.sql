create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
      ('A','Bangalore','A1@gmail.com',1,'CPU'),
      ('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
      ('B','Bangalore','B@gmail.com',2,'DESKTOP'),
      ('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
      ('B','Bangalore','B2@gmail.com',1,'MONITOR');

/* solution */

with tv_cte as
(
select name,count(*) as total_visit from entries group by 1 
),

resource_cte as
(
select name,group_concat(distinct resources) as res from entries group by 1 
),

cte 
as (select name,floor,count(1) as total_visit,rank() over(partition by name order by count(1) desc) as rn
from entries group by 1,2)
       
select a.name,b.total_visit,a.floor as most_visited_floor,c.res 
from cte a 
inner join tv_cte b on a.name=b.name
inner join resource_cte c on b.name=c.name
where a.rn=1