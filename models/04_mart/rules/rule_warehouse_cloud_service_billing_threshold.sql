select

    warehouse_name,
    SUM(credits_used) as credits_used,
    SUM(credits_used_cloud_services) as credits_used_cloud_services,
    SUM(credits_used_cloud_services)
    / SUM(credits_used) as percent_cloud_services,
    --
    warehouse_name as drilldown_id,
    'warehouse' as drilldown_to

from {{ ref('ld__account_usage__warehouse_metering_history') }}

where
    TO_DATE(start_time) >= DATEADD(month, -1, CURRENT_TIMESTAMP())
    and credits_used_cloud_services > 0
    and warehouse_name != 'CLOUD_SERVICES_ONLY'
group by 1
having percent_cloud_services >= 0.1
order by 4 desc
