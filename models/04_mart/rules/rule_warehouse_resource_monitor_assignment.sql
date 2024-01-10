select
    name,
    resource_monitor,
    --
    name as drilldown_id,
    'warehouse' as drilldown_to
from
    {{ ref('ld__warehouses') }}
where
    true
    and (
        resource_monitor is null
        or resource_monitor like 'null'
        or resource_monitor like ''
    )
