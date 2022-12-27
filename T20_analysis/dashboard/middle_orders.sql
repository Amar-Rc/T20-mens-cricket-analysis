select 
NAME, TEAM, BATTING_STYLE, TOTAL_INNINGS_BATTED, TOTAL_RUNS, TOTAL_BALLS_FACED, STRIKE_RATE, BATTING_AVERAGE, BATTING_POSITION, "BOUNDARY%"
from T20_ANALYSIS.PRESENTATION.CRICKET_MEASURES
where batting_average > 40
and strike_rate > 125
and total_innings_batted > 3
and avg_balls_faced > 20
and batting_position > 2
order by total_runs desc;
