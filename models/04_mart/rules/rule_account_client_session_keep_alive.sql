select
    parameter_key,
    parameter_value,
    parameter_default,
    --
    parameter_value as drilldown_id,
    'parameter' as drilldown_to
from
    {{ ref('ld__parameters_in_account') }}
where
    true
    and parameter_key = 'CLIENT_SESSION_KEEP_ALIVE'
    and parameter_value = true
