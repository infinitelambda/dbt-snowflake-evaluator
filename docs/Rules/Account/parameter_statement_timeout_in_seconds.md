# Parameter Statement Timeout in Seconds

## Model name

parameter_statement_timeout_in_seconds

## Description

Cancel long queries after X hours. Most of the cases the default 48 hours looks too high.

## SQL

```
SHOW PARAMETERS LIKE 'statement_timeout%' IN WAREHOUSE; -- at warehouse level

SHOW PARAMETERS LIKE 'statement_timeout%' FOR ACCOUNT; -- at account level

SHOW PARAMETERS LIKE 'statement_timeout%' FOR SESSION; -- at session level

SHOW PARAMETERS LIKE 'statement_timeout%' FOR USER;
```

## Reason to flag

[Snowflake Docs - Snowflake parameter: STATEMENT_TIMEOUT_IN_SECONDS](https://docs.snowflake.com/en/sql-reference/parameters#statement-timeout-in-seconds)

> Amount of time, in seconds, after which a running SQL statement (query, DDL, DML, etc.) is canceled by the system.
>
> Values: 0 to 604800 (i.e. 7 days) — a value of 0 specifies that the maximum timeout value is enforced.
> Default: 172800 (i.e. 2 days)

## How to Remediate

Set it to 8 hours:

```
ALTER WAREHOUSE <warehouse> SET STATEMENT_TIMEOUT_IN_SECONDS = 28800;
```

Here comes a quick help if you need other value.

| hours | min  | sec    |
|-------|------|--------|
| 1     | 60   | 3600   |
| 2     | 120  | 7200   |
| 4     | 240  | 14400  |
| 8     | 480  | 28800  |
| 12    | 720  | 43200  |
| 24    | 1440 | 86400  |
| 48    | 2880 | 172800 |