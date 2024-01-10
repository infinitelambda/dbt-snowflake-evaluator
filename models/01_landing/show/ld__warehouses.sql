{{ config(
  sql_header="SHOW WAREHOUSES;"
) }}

select
    "name" as __id,
    --
    "name" as name,
    "state" as state,
    "type" as type,
    "size" as size,
    "running" as running,
    "queued" as queued,
    "is_default" as is_default,
    "is_current" as is_current,
    "auto_suspend" as auto_suspend,
    "auto_resume" as auto_resume,
    "available" as available,
    "provisioning" as provisioning,
    "quiescing" as quiescing,
    "other" as other,
    "created_on" as created_on,
    "resumed_on" as resumed_on,
    "updated_on" as updated_on,
    "owner" as owner,
    "comment" as comment,
    "resource_monitor" as resource_monitor,
    "actives" as actives,
    "pendings" as pendings,
    "failed" as failed,
    "suspended" as suspended,
    "uuid" as uuid,
    "budget" as budget
    --
{% if var('snowflake_edition') in ('Enterprise',
                                  'Business Critical',
                                  'Virtual Private Snowflake') %}
    ,
    "min_cluster_count" as min_cluster_count,
    "max_cluster_count" as max_cluster_count,
    "started_clusters" as started_clusters,
    "scaling_policy" as scaling_policy,
    "enable_query_acceleration" as enable_query_acceleration,
    "query_acceleration_max_scale_factor" as query_acceleration_max_scale_factor
    
{% endif %}

from
    table(result_scan(last_query_id()))
