use database t20_analysis;
use schema processing;


create or replace table player_info_processing as
select DISTINCT 
TRIM(REPLACE(REPLACE(NAME, '†'),'(c)')) AS NAME,
TEAM,
BATTING_STYLE,
BOWLING_STYLE,
PLAYING_ROLE,
DESCRIPTION
FROM raw.player_info_stg;

select * from player_info_processing;
