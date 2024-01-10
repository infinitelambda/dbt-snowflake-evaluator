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
    and parameter_key in (
        'STATEMENT_TIMEOUT_IN_SECONDS',
        'STATEMENT_QUEUED_TIMEOUT_IN_SECONDS'
    )
    and (
        parameter_value > 86400 or parameter_value = 0
    )
