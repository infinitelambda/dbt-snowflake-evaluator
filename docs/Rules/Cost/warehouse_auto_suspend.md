# Warehouse Auto Suspend

## Model name

warehouse_auto_suspend

## Description

Warehouses can be set to automatically suspend when there’s no activity after a specified period of time. Auto-suspend is enabled by specifying the time period (minutes, hours, etc.) of inactivity for the warehouse.

Snowflake recommends setting auto-suspend according to your workload and your requirements for warehouse availability:

If you enable auto-suspend, we recommend setting it to a low value (e.g. 5 or 10 minutes or less) because Snowflake utilizes per-second billing. This will help keep your warehouses from running (and consuming credits) when not in use.

## SQL

```
-- Show all warehouses in Snowflake account
SHOW WAREHOUSES;

-- Get the Query ID to use later and help speed this up a bit
SET QUERY_ID = (
  SELECT QUERY_ID
  FROM TABLE(SNOWFLAKE.INFORMATION_SCHEMA.QUERY_HISTORY())
  WHERE QUERY_TEXT = 'SHOW WAREHOUSES;'
  ORDER BY START_TIME DESC
  LIMIT 1
); 
-- Find warehouses matching the condition

SELECT "name" as warehouse_name, "auto_suspend" as auto_suspend
FROM TABLE(RESULT_SCAN($QUERY_ID))
WHERE "auto_suspend" > 600 or "auto_suspend" = 0 or "auto_suspend" is null or "auto_suspend" LIKE '' or "auto_suspend" LIKE 'null'
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/warehouses-considerations)

Warehouses with disabled auto_suspend or with auto_suspend set to a high value (more than 10 minutes) might cause excessive and larger than expected Snowflake credit consumption. 

## How to Remediate

Change the auto_suspend parameter value for affected virtual warehouse(s). The value is in seconds, to achieve maximum reduction in credit consumption, it might be worth considering setting the value of this parameter to 60 seconds (which is the minimum time the warehouse will be billed for once after is resumed). 

```
ALTER WAREHOUSE <warehouse_name> SET AUTO_SUSPEND = 60;
```