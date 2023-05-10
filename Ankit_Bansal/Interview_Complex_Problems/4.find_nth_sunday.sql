declare @today_date date
declare @n int
set @today_date = "2023-04-11"
set @n=2

select dateadd(week,@n-1,dateadd(day,8-datepart(weekday,@today_date), @today_date))


-- sunday 1
-- ""
-- saturday 7