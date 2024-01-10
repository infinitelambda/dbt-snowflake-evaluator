with rule_condition as (
    -- Hardcoded part, if there is a new Snowflake edition 
    -- and/or parameter changed, please update
    select
        parameter_key,
        parameter_value,
        parameter_default,
        --
        parameter_value as drilldown_id,
        'parameter' as drilldown_to,
        --
        case
            when
            {%- if var('snowflake_edition') == 'Standard' %}
                    parameter_value = 0
            {%- elif var('snowflake_edition') in ('Enterprise',
                                                'Business Critical', 
                                                'Virtual Private Snowflake') %}
                parameter_value < 7
            {%- else %}
                -- No snowflake_edition was selected 
                -- or there is a new edition
                1 = 1
            {%- endif %}
                then true
            else false
        end as keep_row
    from {{ ref('ld__parameters_in_account') }}
    where
        true
        and parameter_key = 'DATA_RETENTION_TIME_IN_DAYS'

),

final as (

    select * from rule_condition
    where
        true
        and keep_row

)

select * from final
