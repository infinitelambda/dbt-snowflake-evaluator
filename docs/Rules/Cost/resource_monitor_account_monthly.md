# Resource Monitor Account Monthly

## Model name

```
resource_monitor_account_monthly
```

## Description

We suggest to setup a Resource Monitor with a monthly quota at account level. It provides an upper limit for your consumption and your warehouse related costs. Please pay attention to estimate the credit for the quota, sometimes not obvious to get a value which is not disturb your work but not an extremely high level.

## SQL

```
SHOW RESOURCE MONITORS;
select
    *
from
    table(result_scan(last_query_id()))
where
    True
    and level = 'ACCOUNT'
    and frequency = 'MONTHLY';
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/resource-monitors)

> To help control costs and avoid unexpected credit usage caused by running warehouses, Snowflake provides resource monitors. A virtual warehouse consumes Snowflake credits while it runs.
> A resource monitor can be used to monitor credit usage by virtual warehouses and the cloud services needed to support those warehouses. If desired, the warehouse can be suspended when it reaches a credit limit.

## How to Remediate

Setup a monthly limit with 200 credits:

```
CREATE RESOURCE MONITOR "MONTHLY_MAX_200" WITH CREDIT_QUOTA = 200
 TRIGGERS
 ON 100 PERCENT DO SUSPEND
 ON 120 PERCENT DO SUSPEND_IMMEDIATE
 ON 50 PERCENT DO NOTIFY;
ALTER ACCOUNT SET RESOURCE_MONITOR = "MONTHLY_MAX_200";
```