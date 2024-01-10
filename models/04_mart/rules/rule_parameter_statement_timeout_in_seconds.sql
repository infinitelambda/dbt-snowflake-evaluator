select
    parameter_value,
    'Warehouse level' as parameter_level,
    --
    parameter_value as drilldown_id,
    'parameter' as drilldown_to
from {{ ref('ld__parameters_in_warehouse') }}
where parameter_key = 'STATEMENT_TIMEOUT_IN_SECONDS'

union all

select
    parameter_value,
    'Account level' as parameter_level,
    --
    parameter_value as drilldown_id,
    'parameter' as drilldown_to
from {{ ref('ld__parameters_in_account') }}
where parameter_key = 'STATEMENT_TIMEOUT_IN_SECONDS'
