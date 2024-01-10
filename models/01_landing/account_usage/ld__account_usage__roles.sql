select
    role_id as __id,
    --
    role_id,
    created_on,
    deleted_on,
    name,
    comment,
    owner,
    role_type,
    role_database_name,
    role_instance_id
from
    snowflake.account_usage.roles

{% if var("source_filter_out_deleted") %}
-- filter out the deleted objects
where deleted_on is null
{% endif %}
