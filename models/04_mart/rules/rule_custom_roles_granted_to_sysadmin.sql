with base_table as (

    select
        role_id,
        created_on,
        name,
        comment,
        owner,
        role_type,
        role_database_name,
        role_instance_id,
        --
        name as drilldown_id,
        'object' as drilldown_to
    from {{ ref('ld__account_usage__roles') }}
    where
        true
        -- Hardcoded as there is not option to filter out custom roles
        and name not in (
            'ACCOUNTADMIN', 'SECURITYADMIN', 'SYSADMIN', 'USERADMIN', 'PUBLIC'
        )
        and owner != 'SYSADMIN'
        and role_type = 'ROLE'
        and deleted_on is null

),

rule_condition as (

    select
        case
            when count(*) > 0
                then true
            else false
        end as keep_row
    from base_table

),

final as (

    select base_table.*
    from base_table
    inner join rule_condition
    where
        true
        and rule_condition.keep_row

)

select * from final
