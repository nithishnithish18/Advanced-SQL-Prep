create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);


--Method - Self join


with cte_phy as 
(select * from exams where subject="Physics"),
cte_chem as (
select * from exams where subject="Chemistry"
)

select 
a.student_id
from   cte_phy a inner join cte_chem b on a.student_id = b.student_id
where a.marks = b.marks


--Method - Group By and Having Clause

select
student_id
from exams
where subject in ("Physics","Chemistry")
Group by student_id
Having count(distinct subject) = 2 and sum(marks) / 2 = max(marks)