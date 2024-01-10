{{ config(enabled = check_snowflake_edition('Enterprise')) }}

select
    name,
    min_cluster_count,
    --
    name as drilldown_id,
    'warehouse' as drilldown_to
from
    {{ ref('ld__warehouses') }}
where
    true
    and min_cluster_count > 1
