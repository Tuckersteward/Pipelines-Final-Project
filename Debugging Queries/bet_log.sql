select 
	split_part(game_id, '-', 1) as _date,
	split_part(game_id, '-', 2) as home_team,
	split_part(game_id, '-', 3) as away_team, *
from placed_bet_staging;

select count(*) from placed_bet_staging pbs;

with 
customer_cte as (
	select customer_id, 
			concat(customer_first_name, ' ', customer_last_name) as _customer_name
	from customer;
),
staging_cte as (
	select 
		split_part(game_id, '-', 1) as _date,
		split_part(game_id, '-', 2) as home_team,
		split_part(game_id, '-', 3) as away_team,
		bet_amount,
		commision_paid,
		bet_on,
		bet_type,
		c_cte.customer_id,
	from placed_bet_staging pbs inner join customer_cte c_cte on c_cte._customer_name = pbs.customer_name;
),

;

select * from game g 
	inner join teams th on g.team_id_home = th.team_id 
	inner join teams ta on g.team_id_away = ta.team_id
	inner join staging_cte
	;

select * from teams where team_abv = 'KC';

with customer_id_cte as (
	select customer_id, 
			concat(customer_first_name, ' ', customer_last_name) as _customer_name
	from customer
)

select 
	split_part(game_id, '-', 1) as _date,
	split_part(game_id, '-', 2) as home_team,
	split_part(game_id, '-', 3) as away_team,
	ta.team_id as away_team ,
	th.team_id as home_team, 
	game_outcome_id,
	c_cte.customer_id,
	*
from placed_bet_staging pbs inner join teams th on th.team_abv = split_part(pbs.game_id, '-', 2)
	inner join teams ta on ta.team_abv = split_part(pbs.game_id, '-', 3) 
	inner join game g on CONCAT(EXTRACT(YEAR FROM schedule_date)::TEXT, 
        					LPAD(EXTRACT(MONTH FROM schedule_date)::TEXT, 2, '0')) = split_part(pbs.game_id, '-', 1)
	inner join customer_id_cte c_cte on c_cte._customer_name = pbs.customer_name
 limit 250 ;

select * from game;
select game_outcome_id, CONCAT(
        EXTRACT(YEAR FROM schedule_date)::TEXT, 
        LPAD(EXTRACT(MONTH FROM schedule_date)::TEXT, 2, '0')
    ) AS _date, sum(score_home, score_away) 
from game
;
ATL
BAL
KC