create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(25)
);
delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room');

--Use cross apply claue to apply right vlaued expression to each row on left table
--use string split funtion to split string based on sep parameter

select 
value as room_type,
count(1)
from airbnb_searches
cross apply string_split(filter_room_types,',')
group by value
