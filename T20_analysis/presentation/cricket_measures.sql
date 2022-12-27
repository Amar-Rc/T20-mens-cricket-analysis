use database t20_analysis;

use schema presentation;

create or replace temporary view batting_measures as 
select batsman, 
sum(runs) total_runs, 
count(match_id) total_innings_batted, 
sum(out) total_innings_dismissed, 
round(DIV0(sum(runs),sum(out)),2) batting_average, 
sum(balls) total_balls_faced, 
round(DIV0(sum(runs),sum(balls))*100,2) strike_rate, 
round(avg(batting_position)) batting_position, 
round(DIV0((sum(fours)*4 + sum(sixes)*6),sum(runs))*100,2) as "BOUNDARY%",
round(avg(balls),2) avg_balls_faced
from processing.batting_summary_processing group by batsman;

create or replace temporary view bowling_measures as 
select bowler, 
sum(wicket) wickets,
sum(balls) balls_bowled,
sum(runs) runs_conceded,
round(div0(sum(runs), sum(balls)/6),2) bowling_economy,
round(div0(sum(balls), sum(wicket)),2) bowling_strike_rate,
round(div0(sum(runs), sum(wicket)),2) bowling_average,
count(distinct match_id) total_innings_bowled, 
round(div0(sum(zeros), sum(balls))*100,2) "DOT_BALL%",
sum(maiden) maidens
from processing.bowling_summary_processing group by bowler;

desc table processing.batting_summary_processing;

create or replace table cricket_measures as
select 
NAME,
TEAM,
BATTING_STYLE,
BOWLING_STYLE,
PLAYING_ROLE,
TOTAL_RUNS,
TOTAL_INNINGS_BATTED,
TOTAL_INNINGS_DISMISSED,
BATTING_AVERAGE,
TOTAL_BALLS_FACED,
STRIKE_RATE,
BATTING_POSITION,
"BOUNDARY%",
AVG_BALLS_FACED,
WICKETS,
BALLS_BOWLED,
RUNS_CONCEDED,
BOWLING_ECONOMY,
BOWLING_STRIKE_RATE,
BOWLING_AVERAGE,
TOTAL_INNINGS_BOWLED,
"DOT_BALL%",
MAIDENS
from processing.player_info_processing player 
left join batting_measures bat on
player.name = bat.batsman
left join bowling_measures ball on
player.name = ball.bowler;


select * from cricket_measures;


select 
NAME, TEAM, BATTING_STYLE, TOTAL_INNINGS_BATTED, TOTAL_RUNS, TOTAL_BALLS_FACED, STRIKE_RATE, BATTING_AVERAGE, BATTING_POSITION, "BOUNDARY%"
from T20_ANALYSIS.PRESENTATION.CRICKET_MEASURES
where batting_average > 30
and strike_rate > 140
and total_innings_batted > 3
and "BOUNDARY%" > 50
and batting_position < 4;


select * from batting_measures where
batting_average > 30
and strike_rate > 140
and total_innings_batted > 3
and "BOUNDARY%" > 50
and batting_position < 4;

select * from processing.player_info_processing where name in ('Jos Buttler', 'Alex Hales', 'Rilee Rossouw');

select batsman, TOTAL_INNINGS_BATTED, TOTAL_RUNS, TOTAL_BALLS_FACED, STRIKE_RATE, BATTING_AVERAGE, BATTING_POSITION, "BOUNDARY%" from batting_measures where batsman ='Kusal Mendis'

