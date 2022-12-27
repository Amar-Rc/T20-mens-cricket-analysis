select name, team, bowling_style, total_innings_bowled, balls_bowled, runs_conceded, wickets, bowling_economy, bowling_average, bowling_strike_rate, "DOT_BALL%", maidens
from T20_ANALYSIS.PRESENTATION.CRICKET_MEASURES
where total_innings_bowled > 4
and bowling_economy < 7
and bowling_strike_rate < 16
and lower(bowling_style) like '%fast%'
and "DOT_BALL%" > 40
and bowling_average < 20
order by wickets desc;
