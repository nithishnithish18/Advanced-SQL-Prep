CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);


--Amazon SQL Interview Question for BI position
--find total no of messages exchanged between each person per day


--Approach - use horizontal sorting (compare two string, get least and max string)
-- Ascii comparison of strings

select sms_date,p1,p2,sum(sms_no) as total_sms from
(select 
*,
case when sender < receiver then sender else receiver end as p1,
case when sender > receiver then sender else receiver end as p2
from
subscriber)t
group by sms_date,p1,p2