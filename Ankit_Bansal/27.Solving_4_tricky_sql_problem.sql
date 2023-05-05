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











