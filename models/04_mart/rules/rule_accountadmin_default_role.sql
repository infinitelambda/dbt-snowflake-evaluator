select
    user_id,
    name,
    default_role,
    --
    name as drilldown_id,
    'user' as drilldown_to
from
    {{ ref('ld__account_usage__users') }}
where
    default_role = 'ACCOUNTADMIN'
