select
    table_id as __id,
    --
    table_id,
    table_name,
    table_schema_id,
    table_schema,
    table_catalog_id,
    table_catalog,
    table_owner,
    table_type,
    is_transient,
    clustering_key,
    row_count,
    bytes,
    retention_time,
    self_referencing_column_name,
    reference_generation,
    user_defined_type_catalog,
    user_defined_type_schema,
    user_defined_type_name,
    is_insertable_into,
    is_typed,
    commit_action,
    created,
    last_altered,
    last_ddl,
    last_ddl_by,
    deleted,
    auto_clustering_on,
    comment,
    owner_role_type,
    instance_id
from
    snowflake.account_usage.tables

{% if var("source_filter_out_deleted") %}
-- filter out the deleted objects
where deleted is null
{% endif %}
