{{ config(
  sql_header="SHOW PARAMETERS IN ACCOUNT;"
) }}

select
    "key" as __id,
    --
    "key" as parameter_key,
    "value" as parameter_value,
    "default" as parameter_default,
    "level" as parameter_level,
    "description" as parameter_description,
    "type" as parameter_type
from
    table(result_scan(last_query_id()))
