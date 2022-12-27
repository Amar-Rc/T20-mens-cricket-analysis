use database t20_analysis;
use schema processing;

create or replace temporary view temp_bowling_summary as 
(
select a.*, match_lkp.match_id from raw.bowling_summary_stg a, match_lkp
where (match_lkp.match1 = a.match or match_lkp.match2 = a.match));

create or replace table bowling_summary_processing as
select distinct 
match,
bowling_team as team,
trim(replace(replace(bowler, '†'),'(c)')) as bowler,
overs::float as overs,
nvl(split(overs,'.')[0], 0)::int*6 + nvl(split(overs,'.')[1], 0)::int as balls,
maiden::int as maiden,
runs::int as runs,
wickets::int as wicket,
economy::float as economy,
"0s"::int as zeros,
"4s"::int as fours,
"6s"::int as sixes,
"wides"::int as wides,
"no_balls"::int as no_balls,
MATCH_ID 
from temp_bowling_summary;

select * from bowling_summary_processing;
