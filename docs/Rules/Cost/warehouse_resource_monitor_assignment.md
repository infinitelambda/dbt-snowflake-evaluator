# Warehouse Resource Monitor Assignment

## Model name

warehouse_resource_monitor_assignment

## Description

To help control costs and avoid unexpected credit usage caused by running warehouses, Snowflake provides resource monitors. Monitor level property specifies whether the resource monitor is used to monitor the credit usage for your entire Account (i.e. all warehouses in the account) or a specific set of individual warehouses. Having a resource monitor set up for each virtual warehouse allows for regular monitoring of the credit consumption.

## SQL

```
-- Setup and context
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE <Your Warehouse>;

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

SELECT "name" as warehouse_name, "resource_monitor" as resource_monitor
FROM TABLE(RESULT_SCAN($QUERY_ID))
WHERE "resource_monitor" is null or "resource_monitor" LIKE 'null' or "resource_monitor" LIKE '' 
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/resource-monitors)

Setting a resource monitor allows specifying actions (e.g. notifications) which should take place in case credit consumption exceed specified levels. This feature cannot be fully utilized if some warehouses are not assigned to a resource monitor.

## How to Remediate

Assign a resource monitor to a virtual warehouse:

```
ALTER WAREHOUSE SET RESOURCE MONITOR = <resource_monitor_name>;
```

For details about how to create a new resource monitor, please consult [Snowflake Docs](https://docs.snowflake.com/en/sql-reference/sql/create-resource-monitor).