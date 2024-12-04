-- delete from game where 1=1;

select setval(
    pg_get_serial_sequence('game', 'game_outcome_id'),
    coalesce(max(game_outcome_id), 1),
    false)
from game;

select count(*)
from game;

select * from game where stadium_neutral = true;

--update game set weather_detail = NULL where weather_detail = 'NaN'


select * 
from game 
where team_id_home in (
		select team_id_home
		from game
		group by schedule_date, 
				team_id_home
		order by count(*) desc)
	and team_id_home = 4
order by schedule_date;
-- 4: "Baltimore Ravens"

select team_id_home, 
		count(*)
from game
group by schedule_date, 
		team_id_home
having count(*) > 1
order by team_id_home, 
		count(*) desc;

select * from teams
where team_id = 4;


select * 
from teams 
where team_id = 4;

select customer_first_name, customer_last_name, count(*)
from customer c
group by customer_first_name, customer_last_name
order by count(*) desc;

select * from customer c where customer_first_name = 'Ivanna'