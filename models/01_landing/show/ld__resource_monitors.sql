{{ config(
  sql_header="SHOW RESOURCE MONITORS;"
) }}

select
    "name" as __id,
    --
    "name" as name,
    "credit_quota" as credit_quota,
    "used_credits" as used_credits,
    "remaining_credits" as remaining_credits,
    "level" as level,
    "frequency" as frequency,
    "start_time" as start_time,
    "end_time" as end_time,
    "notify_at" as notify_at,
    "suspend_at" as suspend_at,
    "suspend_immediately_at" as suspend_immediately_at,
    "created_on" as created_on,
    "owner" as owner,
    "comment" as comment,
    "notify_users" as notify_users
from
    table(result_scan(last_query_id()))
