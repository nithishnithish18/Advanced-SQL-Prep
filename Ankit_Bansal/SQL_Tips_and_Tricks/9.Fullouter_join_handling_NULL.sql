create table emp_2020
(
emp_id int,
designation varchar(20)
);

create table emp_2021
(
emp_id int,
designation varchar(20)
)

insert into emp_2020 values (1,'Trainee'), (2,'Developer'),(3,'Senior Developer'),(4,'Manager');
insert into emp_2021 values (1,'Developer'), (2,'Developer'),(3,'Manager'),(5,'Trainee');




--Find employee who got Promoted and joined between 2020 and 2021
-- Full outer join method with handling NULL values using ISNULL() method

select isnull(a.emp_id,b.emp_id) as emp_id,
case 
when a.designation is not null and b.designation is not null and a.designation != b.designation then "Promoted"
when a.designation is null and  b.designation is not null then "New"
else "Resigned"
end as col
from
emp_2020 a full outer join emp_2021 b
on a.emp_id = b.emp_id
where  isnull(a.designation,"xxx") != isnull(b.designation,"xxx")
