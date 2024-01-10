with base_table as (

    select
        *,
        --
        name as drilldown_id,
        'object' as drilldown_to
    from
        {{ ref('ld__network_policies') }}

),

rule_condition as (

    select
        case
            when count(*) = 0
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
