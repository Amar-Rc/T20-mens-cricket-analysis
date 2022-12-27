use database t20_analysis;

use schema raw;

create or replace storage integration s3_connect
type = external_stage
storage_provider = S3
enabled = true
storage_aws_role_arn = [REDACTED]
storage_allowed_locations = ('s3://[REDACTED]/t20_json_files/');

desc integration s3_connect;

create or replace file format manage_db.file_formats.json_fileformat
type=json;

create or replace stage manage_db.external_stages.s3_stage
url = 's3://[REDACTED]/t20_json_files/t20_wc_match_results.json'
storage_integration = s3_connect
file_format = manage_db.file_formats.json_fileformat;

create or replace table T20_analysis.raw.match_result_stg
(team1 varchar,
 team2 varchar,
 winner varchar,
 margin varchar,
 ground varchar,
 match_date varchar,
 match_id varchar
);

INSERT INTO T20_analysis.raw.match_result_stg 
select t.value:team1::STRING,
t.value:team2::STRING,
t.value:winner::STRING,
t.value:margin::STRING,
t.value:ground::STRING,
t.value:matchDate::STRING as match_date,
t.value:scorecard::STRING as match_id
from @manage_db.external_stages.s3_stage S, table(flatten(S.$1[0],'matchSummary')) t;

select * from T20_analysis.raw.match_result_stg;

desc table match_result_stg;
