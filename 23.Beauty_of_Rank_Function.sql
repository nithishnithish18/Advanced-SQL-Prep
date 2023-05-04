create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);


select * from covid;

--Method - Lead and Lag

with cte as (
select 
city,
cases,
case
when lead(cases,1) over(partition by city order by days) > cases or lead(cases,1) over(partition by city order by days) is null  then 0
else 1 end  as flag
from covid)

select city from cte
group by city
having sum(flag) < 1

--Method- Rank 

with cte as(
select 
*,
rank() over(partition by city order by days) as rn1,
rank() over(partition by city order by cases) as rn2,
rank() over(partition by city order by days) - rank() over(partition by city order by cases) as diff
from covid
)

select 
city 
from cte
group by city 
having count(distinct diff) = 1 and max(diff) = 0
