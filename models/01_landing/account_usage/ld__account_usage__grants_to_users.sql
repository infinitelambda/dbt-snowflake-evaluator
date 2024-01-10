select
    {{ columns_to_string(["role",
                        "granted_to",
                        "grantee_name",
                        "granted_by",
                        "deleted_on"]) }} as __id,
    --
    created_on,
    deleted_on,
    role,
    granted_to,
    grantee_name,
    granted_by
from
    snowflake.account_usage.grants_to_users

{% if var("source_filter_out_deleted") %}
-- filter out the deleted objects
where deleted_on is null
{% endif %}
