with base_table as (

    select
        *,
        --
        name as drilldown_id,
        'resource monitor' as drilldown_to
    from
        {{ ref('ld__resource_monitors') }}
    where
        True
        and level = 'ACCOUNT'
        and frequency = 'MONTHLY'

),

rule_condition as (

    select
        case
            when (
                count(*) = 0
            )
                then True
            else False
        end as keep_row
    from base_table

),

final as (

    select base_table.*
    from base_table
    inner join rule_condition
    where
        True
        and rule_condition.keep_row

)

select * from final
