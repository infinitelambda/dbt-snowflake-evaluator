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
    True
    and parameter_value = parameter_default
    and parameter_key = 'TIMEZONE'
