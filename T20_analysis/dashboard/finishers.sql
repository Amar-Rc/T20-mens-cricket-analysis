select name, team, batting_style, bowling_style, total_innings_batted, total_runs, avg_balls_faced, batting_average, strike_rate, total_innings_bowled, wickets, bowling_economy, bowling_strike_rate, maidens
from T20_ANALYSIS.PRESENTATION.CRICKET_MEASURES
where batting_average > 25
and strike_rate > 130
and total_innings_batted > 3
and avg_balls_faced > 12
and batting_position > 4
and total_innings_bowled > 1
order by strike_rate desc;
