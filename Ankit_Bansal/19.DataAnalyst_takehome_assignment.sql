CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

--4. percentage of paid users in India,USA and other country should be tagged as Others


with cte as (
select 
*,
case
when country !="India" and country!="USA" then "Others" 
else country end as new_country
from activity where event_name="app-purchase"
)
select distinct new_country,1.0 * count(user) over(partition by new_country)/count(user) over() * 100 from cte


--5.Among all the users who installed the app on given day,how many did in app purchase on very next day


with cte as (

select *,lag(event_date,1) over(partition by user_id order by event_date ) as prev_day from activity

)

select
A.event_date,
count(distinct B.user_id) as users_cnt
from 
activity A left join cte B 
on A.user_id = B.user_id 
and A.event_date = B.event_date 
and datediff(day,B.prev_day,A.event_date) = 1
group by A.event_date

















