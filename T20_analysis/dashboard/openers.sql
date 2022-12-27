select 
NAME, TEAM, BATTING_STYLE, TOTAL_INNINGS_BATTED, TOTAL_RUNS, TOTAL_BALLS_FACED, STRIKE_RATE, BATTING_AVERAGE, BATTING_POSITION, "BOUNDARY%"
from T20_ANALYSIS.PRESENTATION.CRICKET_MEASURES
where batting_average > 30
and strike_rate > 140
and total_innings_batted > 3
and "BOUNDARY%" > 50
and batting_position < 4
order by total_runs desc;
