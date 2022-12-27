select name, team, batting_style, bowling_style, total_innings_batted, total_runs, batting_average, strike_rate, total_innings_bowled, balls_bowled, wickets, bowling_economy, bowling_strike_rate, maidens
from T20_ANALYSIS.PRESENTATION.CRICKET_MEASURES
where batting_average > 15
and strike_rate > 140
and total_innings_batted > 2
and batting_position > 4
and total_innings_bowled > 2
and bowling_economy < 7
and bowling_strike_rate < 20
order by strike_rate desc;
