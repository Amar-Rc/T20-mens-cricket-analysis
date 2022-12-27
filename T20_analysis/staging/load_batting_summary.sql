use database t20_analysis;

use schema raw;

create or replace stage manage_db.external_stages.s3_stage_1
url = 's3://[REDACTED]/t20_json_files/t20_wc_batting_summary.json'
storage_integration = s3_connect
file_format = manage_db.file_formats.json_fileformat;


create or replace table batting_summary_stg as
select t.value:"match"::STRING as match,
t.value:"teamInnings"::STRING as team_innings,
t.value:"battingPos"::STRING as batting_position,
t.value:"batsmanName"::STRING as batsman,
t.value:"dismissal"::STRING as dismissal,
t.value:"runs"::STRING as runs,
t.value:"balls"::STRING as balls,
t.value:"4s"::STRING as "4s",
t.value:"6s"::STRING as "6s",
t.value:"SR"::STRING as "SR"
from (select tgt.value from @manage_db.external_stages.s3_stage_1 stg,
table(flatten(stg.$1)) tgt) S,
table(flatten(S.$1, 'battingSummary')) t;



select * from batting_summary_stg;
