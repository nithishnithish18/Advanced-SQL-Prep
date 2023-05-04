create table person(PersonID int,Name varchar(20),Email varchar(50),Score int);

insert into person values (1	,"Alice","alice2018@hotmail.com",88);
insert into person values (2	,"Bob","bob2018@hotmail.com",11);
insert into person values (3	,"Davis","davis@hotmail.com",27);
insert into person values (4	,"tara","tara2018@hotmail.com",45);
insert into person values (5	,"john","john2018@hotmail.com",63);

create table friend(PersonID int,FriendID int);

insert into friend values (1,2);
insert into friend values (1,3);
insert into friend values (2,1);
insert into friend values (2,3);
insert into friend values (3,5);
insert into friend values (4,2);
insert into friend values (4,3);
insert into friend values (4,5);


with friend_mark as (
select a.PersonID, a.FriendID,b.Score as friend_score from friend a left join person b on a.FriendID = b.PersonID 
),

cte as (
select a.*,b.friend_score from person a left join friend_mark b on a.PersonID = b.PersonID
)
-- select * from cte

select PersonID,Name, count(*) as no_of_friends,sum(friend_score)  as total_friend_score
from cte group by PersonID, Name 
having sum(friend_score) > 100