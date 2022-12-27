use database t20_analysis;
use schema processing;

create or replace table match_lkp as
select concat(team1,' Vs ', team2) as match1, 
concat(team2,' Vs ', team1) as match2,
match_id from raw.match_result_stg;

create or replace temporary view temp_batting_summary as 
(
select a.*, match_lkp.match_id from raw.batting_summary_stg a, match_lkp
where (match_lkp.match1 = a.match or match_lkp.match2 = a.match));

create or replace table batting_summary_processing as
select match,
team_innings,
batting_position,
trim(replace(replace(batsman, '†'),'(c)')) as batsman,
runs::int as runs,
balls::int as balls,
"4s"::int as fours,
"6s"::int as sixes,
SR,
case when "out/not_out" = 'out' then 1 else 0 end as out,
match_id from
(select t.*, case when dismissal='' then 'not_out' else 'out' end "out/not_out" from temp_batting_summary t);
