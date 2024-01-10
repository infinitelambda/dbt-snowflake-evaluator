select
    user_id,
    name,
    last_success_login,
    --
    name as drilldown_id,
    'user' as drilldown_to
from
    {{ ref('ld__account_usage__users') }}
where
    true
    and name not in ('SNOWFLAKE')
    and deleted_on is null
    -- haven’t used Snowflake in the last 90 days)
    and last_success_login < DATEADD(day, -90, CURRENT_TIMESTAMP())
