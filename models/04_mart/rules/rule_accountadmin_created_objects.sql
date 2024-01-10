select
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
    object_instance,
    --
    name as drilldown_id,
    'object' as drilldown_to
from
    {{ ref('ld__account_usage__grants_to_roles') }}
where
    true
    and deleted_on is null
    and granted_to = 'ROLE'
    and grantee_name = 'ACCOUNTADMIN'
    and granted_by = 'ACCOUNTADMIN'
    and privilege = 'OWNERSHIP'
    -- objects 
    and granted_on not in (
        'INTEGRATION',
        'RESOURCE MONITOR',
        'SHARE',
        'NOTIFICATION SUBSCRIPTION',
        'MANAGED ACCOUNT'
    )
