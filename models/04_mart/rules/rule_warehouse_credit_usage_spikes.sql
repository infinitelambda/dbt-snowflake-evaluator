with stg__warehouse_metering_history as (

    select * from {{ ref('ld__account_usage__warehouse_metering_history') }}

),


wh_daily_credit_consumption as (

    select

        warehouse_id,
        warehouse_name,
        DATE(start_time) as start_date,
        SUM(credits_used) as daily_credit_usage

    from stg__warehouse_metering_history
    where
        start_date between DATEADD(day, -8, CURRENT_DATE())
        and DATEADD(day, -1, CURRENT_DATE())
    group by 1, 2, 3

),

wh_seven_day_average as (

    select

        warehouse_id,
        warehouse_name,
        AVG(daily_credit_usage) as seven_day_average_usage

    from wh_daily_credit_consumption
    where start_date <= DATEADD(day, -2, CURRENT_DATE())
    group by 1, 2

),

final as (

    select

        a.warehouse_id,
        a.warehouse_name,
        a.seven_day_average_usage,
        c.daily_credit_usage as previous_day_usage,
        --
        a.warehouse_name as drilldown_id,
        'warehouse' as drilldown_to

    from wh_seven_day_average as a
    left join wh_daily_credit_consumption as c
        on (
            a.warehouse_id = c.warehouse_id
            and c.start_date = DATEADD(day, -1, CURRENT_DATE())
        )
    where c.daily_credit_usage > 4 * a.seven_day_average_usage

)

select * from final
where warehouse_name != 'CLOUD_SERVICES_ONLY'
