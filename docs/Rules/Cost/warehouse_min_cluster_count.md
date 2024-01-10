# Warehouse Min CLuster Count

## Model name

warehouse_min_cluster_count

## Description

With multi-cluster warehouses, Snowflake supports allocating, either statically or dynamically, additional clusters to make a larger pool of compute resources available. For a warehouse, it is possible to specify minimum number of clusters that will run when the warehouse is resumed. 

This feature is available only in Snowflake Enterprise edition (or higher).

## SQL

```
-- Setup and context
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE <Your Warehouse>;

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

SELECT "name" as warehouse_name, "min_cluster_count" as min_cluster_count
FROM TABLE(RESULT_SCAN($QUERY_ID))
WHERE "min_cluster_count" > 1
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/warehouses-multicluster)

If min_cluster_count>1 then more than one cluster will run each time the warehouse is resumed, potentially causing excessive credit consumption.  

## How to Remediate

Change the min_cluster_count parameter value for affected virtual warehouse(s).

```
ALTER WAREHOUSE <warehouse_name> SET MIN_CLUSTER_COUNT = 1;
```