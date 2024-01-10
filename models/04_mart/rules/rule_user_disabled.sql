select
    user_id,
    name,
    --
    name as drilldown_id,
    'user' as drilldown_to
from
    {{ ref('ld__account_usage__users') }}
where
    true
    and name not in ('SNOWFLAKE')
    and deleted_on is null
    and disabled = true
