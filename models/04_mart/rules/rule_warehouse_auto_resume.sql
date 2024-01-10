select
    name,
    auto_resume,
    --
    name as drilldown_id,
    'warehouse' as drilldown_to
from
    {{ ref('ld__warehouses') }}
where
    True
    and auto_resume = False
