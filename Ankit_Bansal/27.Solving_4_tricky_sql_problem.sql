CREATE TABLE [students](
 [studentid] [int] NULL,
 [studentname] [nvarchar](12) NULL,
 [subject] [nvarchar](10) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
)
data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');


--SQL set with 4 medium to high complexity problems

-- select * from students


--1. Get list of students who scored above the average marks in each subject

--using window functions

select * from
(select 
*,
case when marks > avg(marks) over(partition by subject) then 1 else 0 end as flag
from students)t
where flag = 1

--using joins and group by 

with avg_cte as
(
select 
subject,
avg(marks) as avg_mark
from students
group by subject
)

select
a.*,
b.avg_mark 
from students a left join avg_cte b on a.subject =b.subject
where a.marks > b.avg_mark


--2.get the percentage of students who score more than 90 in any subject among the total students

-- using CTE 

with cte as 
(
  select 
  studentid,
  Max(case when marks > 90 then 1 else 0 end) as flag
  from students
  group by studentid
)
select 1.0 * sum(flag)/count(distinct studentid) * 100 from  cte


--using aggregation functions

select 
1.0 * count(distinct case when marks > 90 then studentid else NULL end) / count(distinct studentid) * 100 as perc
from students


--3. get the second highest and second lowest marks for each subject

--using CTE

with cte_2h as (
select 
subject,
marks as second_highest_marks,
dense_rank() over(partition by subject order by marks desc) as rnh 
from students
),
cte_2l as (
select 
subject,
marks as second_lowest_marks,
dense_rank() over(partition by subject order by marks asc) as rnl
from students
)
select 
distinct a.subject,
second_highest_marks,
second_lowest_marks
from students a left join cte_2l b on a.subject = b.subject
left join cte_2h c on a.subject = c.subject
where rnl = 2 and rnh = 2







