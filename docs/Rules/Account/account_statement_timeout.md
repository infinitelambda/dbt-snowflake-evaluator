# Account Statement Timeout

## Model name

account_statement_timeout

## Description

Parameters STATEMENT_QUEUED_TIMEOUT_IN_SECONDS and  STATEMENT_TIMEOUT_IN_SECONDS can be used to automatically stop queries that are taking too long to execute, either due to a user error or a frozen cluster. They can be set at an account level (the scope of this rule) or lower level (e.g. warehouse, session, user,...). The lower level settings take precedence.

This rule checks whether the two parameters are in the interval between 0 and 1 day. 

## SQL

```
select
    parameter_key,
    parameter_value,
    parameter_default
from
    {{ ref('stg__parameters_in_account') }}
where True
    and  parameter_key in ('STATEMENT_TIMEOUT_IN_SECONDS', 'STATEMENT_QUEUED_TIMEOUT_IN_SECONDS')
    and (parameter_value > 172800 or parameter_value = 0)
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/parameters?_ga=2.199115242.49086499.1699365509-1965691647.1658146707#statement-queued-timeout-in-seconds)

These two parameters help prevent blocking of compute resources due to long running queries or warehouse-related issues.  

## How to Remediate

Set up the values for the two parameters in seconds (e.g. 8 hours ~ 22 800 seconds):

```
ALTER ACCOUNT SET STATEMENT_TIMEOUT_IN_SECONDS= 28800;
ALTER ACCOUNT SET STATEMENT_QUEUED_TIMEOUT_IN_SECONDS= 28800;
```