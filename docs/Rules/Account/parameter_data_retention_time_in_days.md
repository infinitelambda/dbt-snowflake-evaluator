# Parameter Data Retention Time in Days

## Model name

parameter_data_retention_time_in_days

## Description

Extend the default 1 day regarding Time Travel interval. Often not so much cost compare to the benefit it provides.

DEPENDS ON THE EDITION THE ACCOUNT USES! At the moment the only way to query the edition using ORGADMIN role!

## SQL

```
-- NEED ORGADMIN role!!!
use role orgadmin;
show organization accounts;
-- Look for the column "edition"
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/parameters#label-data-retention-time-in-days)

> Number of days for which Snowflake retains historical data for performing Time Travel actions (SELECT, CLONE, UNDROP) on the object. A value of 0 effectively disables Time Travel for the specified database, schema, or table. For more information, see Understanding & Using Time Travel.
> 
> Values: 0 or 1 (for Standard Edition)
>         0 to 90 (for Enterprise Edition or higher)
>
> Default: 1

## How to Remediate

Set the time travel to 7 days at account level (need Enterprise Edition!):

```
use role accountadmin;
-- show the current
show parameters in account;
-- extend it to 7 days
ALTER ACCOUNT SET DATA_RETENTION_TIME_IN_DAYS=7;
-- check it
show parameters like 'DATA_RETENTION_TIME_IN_DAYS%' in account;
```