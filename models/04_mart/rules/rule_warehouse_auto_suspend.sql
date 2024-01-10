select
    name,
    auto_suspend,
    --
    name as drilldown_id,
    'warehouse' as drilldown_to
from
    {{ ref('ld__warehouses') }}
where
    true
    and (
        auto_suspend > 600
        or auto_suspend = 0
        or auto_suspend is null
        or auto_suspend like ''
        or auto_suspend like 'null'
    )
