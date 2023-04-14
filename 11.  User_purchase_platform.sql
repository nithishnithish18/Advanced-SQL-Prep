 create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);




 -- my solution
with cte as (
select spend_date,user_id,sum(amount) as amt,count(distinct platform) as cnt,max(platform) as plt  from spending group by spend_date,user_id
),

cte2 as (
select *, case 
when plt = "desktop" and cnt=1 then plt
when plt = "mobile" and cnt=1 then plt
else "both" end as plt_new
from cte ),

cte3 as (
select * from  cte2 where plt_new="both"
union all
select distinct spend_date, null as user_id, 0 as amt, null as cnt, null as plt, "both" as plt_new from cte2
),

cte4 as (
select spend_date, plt_new,sum(amt) as amt,count(distinct user_id) as total_users from cte3 group by spend_date,plt_new
union all
select spend_date, plt_new,sum(amt) as amt,count(distinct user_id) as total_users  from  cte2 where plt_new!="both"  group by spend_date,plt_new 
)

select spend_date, plt_new, sum(amt), sum(total_users) from cte4 group by spend_date, plt_new



-- optimized


with cte as (
select spend_date, user_id, sum(amount) as amt,max(platform) as platform from spending
group by spend_date,user_id having count(distinct platform) = 1
union all
select spend_date, user_id, sum(amount) as amt,"both" as platform from spending
group by spend_date, user_id having count(distinct platform) = 2
union all
select distinct spend_date, null as user_id, 0 as amt, 'both' as platform from spending
)

select spend_date,platform,sum(amt),count(distinct user_id) from cte group by spend_date,platform 
order by spend_date,platform desc
