create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

--Get the public holidays
with cte as(
select 
a.ticket_id,
a.create_date,
a.resolved_date,
count(b.holiday_date) as public_holidays 
from
tickets a 
left join 
holidays b 
on b.holiday_date between a.create_date and a.resolved_date
group by ticket_id,create_date,resolved_date
)

--get the actual days,business days and final days
select 
ticket_id,
resolved_date,
datediff(day,create_date,resolved_date) as actual_days,
datediff(day,create_date,resolved_date) - 2 * datediff(week,create_date,resolved_date) as business_days,
datediff(day,create_date,resolved_date) - 2 * datediff(week,create_date,resolved_date) - public_holidays as final_days
from
cte
