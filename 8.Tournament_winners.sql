create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

-- select * from matches;
-- select * from players;

-- my solution

with cte as
(
select a.player_id,a.group_id,b.first_score,c.second_score from players a 
left join matches b on a.player_id = b.first_player
left join matches c on a.player_id = c.second_player
),

cte2 as (
select  group_id, player_id, sum(isnull(first_score,0) + isnull(second_score, 0)) as final_score from cte
group by group_id, player_id
)

select * from(
select *,row_number() over(partition by group_id order by final_score desc) as rn from cte2
)t where rn=1
order by group_id