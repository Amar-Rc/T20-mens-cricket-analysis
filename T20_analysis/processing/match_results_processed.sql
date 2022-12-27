use database t20_analysis;
use schema processing;

create or replace temporary view match_results_temp as 
select 
TEAM1,
TEAM2,
WINNER,
MARGIN,
GROUND,
to_date(MATCH_DATE, 'MON DD, YYYY') as MATCH_DATE,
MATCH_ID from raw.match_result_stg;

create or replace table match_results_processing as
select 
TEAM1,
TEAM2,
WINNER,
MARGIN,
GROUND,
MATCH_DATE,
CASE WHEN MATCH_DATE < '2022-10-22' then 'Qualifier' else 'Super 12' end as STAGE,
MATCH_ID
from match_results_temp;

select * from match_results_processing;

