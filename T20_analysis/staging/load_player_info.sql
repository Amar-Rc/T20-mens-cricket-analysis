use database t20_analysis;

use schema raw;

create or replace stage manage_db.external_stages.s3_stage_3
url = 's3://[REDACTED]/t20_json_files/t20_wc_player_info.json'
storage_integration = s3_connect
file_format = manage_db.file_formats.json_fileformat;

create or replace table player_info_stg as
select tgt.value:name::STRING as name,
tgt.value:team::STRING as team,
tgt.value:battingStyle::STRING as batting_style,
tgt.value:bowlingStyle::STRING as bowling_style,
tgt.value:playingRole::STRING as playing_role,
tgt.value:description::STRING as description
from @manage_db.external_stages.s3_stage_3 stg,
table(flatten(stg.$1)) tgt;

select * from player_info_stg;
