# Warehouse Auto Resume

## Model name

```
warehouse_auto_resume
```

## Description

Make sure all virtual warehouses are set to auto-resume. If you are going to implement auto-suspend and set appropriate timeout limits, enabling auto-resume is a must; otherwise, users will not be able to query the system. 

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

SELECT "name" as warehouse_name, "auto_resume" as auto_resume
FROM TABLE(RESULT_SCAN($QUERY_ID))
WHERE "auto_resume" = FALSE
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/warehouses-considerations)

If auto resume is not enabled, the users will not be able to run queries using the warehouse (unless they explicitly resume the warehouse using ALTER WAREHOUSE statement). 

## How to Remediate

Change the auto_resume parameter value for affected virtual warehouse(s).

```
ALTER WAREHOUSE <warehouse_name> SET AUTO_RESUME = TRUE;
```