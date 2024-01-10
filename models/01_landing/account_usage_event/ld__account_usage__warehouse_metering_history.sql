select
    start_time,
    end_time,
    warehouse_id,
    warehouse_name,
    credits_used,
    credits_used_compute,
    credits_used_cloud_services
from
    snowflake.account_usage.warehouse_metering_history

{% if var("source_filter_on_historical")|length %}
-- narrow down the time interval
where start_time >= sysdate() - INTERVAL '{{ var("source_filter_on_historical") }}'
{% endif %}
