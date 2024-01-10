select
    {{ columns_to_string(["created_on",
                        "privilege",
                        "granted_on",
                        "name",
                        "table_catalog",
                        "table_schema",
                        "granted_to",
                        "grantee_name",
                        "deleted_on"]) }} as __id,
    --
    created_on,
    modified_on,
    privilege,
    granted_on,
    name,
    table_catalog,
    table_schema,
    granted_to,
    grantee_name,
    grant_option,
    granted_by,
    deleted_on,
    granted_by_role_type,
    object_instance
from
    snowflake.account_usage.grants_to_roles

{% if var("source_filter_out_deleted") %}
-- filter out the deleted objects
where deleted_on is null
{% endif %}
