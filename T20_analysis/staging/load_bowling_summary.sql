use database t20_analysis;

use schema raw;

create or replace stage manage_db.external_stages.s3_stage_2
url = 's3://[REDACTED]/t20_json_files/t20_wc_bowling_summary.json'
storage_integration = s3_connect
file_format = manage_db.file_formats.json_fileformat;


create or replace table bowling_summary_stg as
select t.value:"match"::STRING as match,
t.value:"bowlingTeam"::STRING as bowling_team,
t.value:"bowlerName"::STRING as bowler,
t.value:"overs"::STRING as overs,
t.value:"maiden"::STRING as maiden,
t.value:"runs"::STRING as runs,
t.value:"wickets"::STRING as wickets,
t.value:"economy"::STRING as economy,
t.value:"0s"::STRING as "0s",
t.value:"4s"::STRING as "4s",
t.value:"6s"::STRING as "6s",
t.value:"wides"::STRING as "wides",
t.value:"noBalls"::STRING as "no_balls"
from (select tgt.value from @manage_db.external_stages.s3_stage_2 stg,
table(flatten(stg.$1)) tgt) S,
table(flatten(S.$1, 'bowlingSummary')) t;



select * from bowling_summary_stg;
