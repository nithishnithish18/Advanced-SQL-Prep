create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


select team,count(1) as no_match_palyed,sum(win_flag) as no_match_won,count(1) - sum(win_flag) as no_loss
from
(
select Team_1 as team,
case
  when winner=Team_1 then 1 
  else 0
end as
  win_flag
from
  icc_world_cup
union all
select Team_2 as team,
case
  when winner=Team_2 then 1 
  else 0
end as
  win_flag
from 
  icc_world_cup
) A
group by team
order by no_match_won desc