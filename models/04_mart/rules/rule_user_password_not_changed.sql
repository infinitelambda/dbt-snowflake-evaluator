select
    user_id,
    name,
    has_password,
    password_last_set_time,
    --
    name as drilldown_id,
    'user' as drilldown_to
from
    {{ ref('ld__account_usage__users') }}
where
    true
    and name not in ('SNOWFLAKE')
    and deleted_on is null
    and has_password = true
    -- hasn’t changed in the last 180 days)
    and password_last_set_time < DATEADD(day, -180, CURRENT_TIMESTAMP())
