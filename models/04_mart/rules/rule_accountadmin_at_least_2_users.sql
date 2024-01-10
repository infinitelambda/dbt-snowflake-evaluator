with base_table as (
    -- create a base table: join the users and roles -> result: user-role, 
    -- and filter it to the users with accountadmin roles
    select
        u.name,
        gto.role,
        u.email,
        --
        u.name as drilldown_id,
        'user' as drilldown_to
    from {{ ref('ld__account_usage__users') }} as u
    inner join {{ ref('ld__account_usage__grants_to_users') }} as gto
        on u.name = gto.grantee_name
    where
        true
        and u.deleted_on is null
        and gto.deleted_on is null
        and gto.role = 'ACCOUNTADMIN'

),

rule_condition as (
    -- create a condition to have at least 2 users assigned 
    -- with accountadmin role
    select
        case
            when count(*) < 2
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
