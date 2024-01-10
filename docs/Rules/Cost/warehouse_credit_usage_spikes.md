# Warehouse Credit Usage Spikes

## Model name

warehouse_credit_usage_spikes

## Description

This rule aims to identify warehouse credit usage that deviates from a pre-defined rule (e.g. daily credit consumption for the previous day exceeded the previous seven-day's credit consumption average at least four times).

## SQL

```
with wh_daily_credit_consumption as (
  
    select warehouse_id,
        warehouse_name,
        DATE(start_time) as date,
        sum(credits_used) as daily_credit_usage
    from SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
    where date between DATEADD(DAY,-8,CURRENT_DATE()) AND DATEADD(DAY,-1,CURRENT_DATE())
    group by 1,2,3

),

wh_seven_day_average as (

    select warehouse_id,
           warehouse_name,
           avg(daily_credit_usage) as seven_day_average_usage 
    from wh_daily_credit_consumption
    where date<=DATEADD(DAY,-2,CURRENT_DATE())
    group by 1,2

),

final as (

    select a.warehouse_id,
           a.warehouse_name,
           a.seven_day_average_usage,
           c.daily_credit_usage as previous_day_usage

   from wh_seven_day_average as a
   left join wh_daily_credit_consumption as c on (a.warehouse_id=c.warehouse_id and c.date=DATEADD(DAY,-1,CURRENT_DATE()))
   where c.daily_credit_usage > 4*a.seven_day_average_usage 

)

select * from final
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/warehouses-considerations)

To identify spikes in warehouse credit consumption, for example if a user set a warehouse to a larger size to do some specific task but did not put it back the way he found it.

## How to Remediate

Re-size the warehouse: 

```
ALTER WAREHOUSE <warehouse_name> SET WAREHOUSE_SIZE = XSMALL;
```