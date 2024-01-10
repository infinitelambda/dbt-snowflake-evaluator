with acc as (

    select
        u.name,
        u.user_id,
        u.login_name,
        ug.role,
        u.created_on,
        u.email,
        u.ext_authn_duo,
        --
        u.login_name as drilldown_id,
        'user' as drilldown_to
    from {{ ref('ld__account_usage__grants_to_users') }} as ug
    inner join {{ ref('ld__account_usage__users') }} as u
        on u.name = ug.grantee_name
    where
        true
        and ug.deleted_on is null
        and u.deleted_on is null
        and ug.role = 'ACCOUNTADMIN'

)

select *
from acc
where email is null
