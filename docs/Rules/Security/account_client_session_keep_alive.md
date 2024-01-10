# Account Client Session Keep Alive

## Model name

account_client_session_keep_alive

## Description

CLIENT_SESSION_KEEP_ALIVE is a parameter that indicates whether to force a user to log in again after a period of inactivity in the session. It can be set at an account level or lower levels (users, session). The default value and recommended value for account level setting is FALSE.

## SQL

```
select
    parameter_key,
    parameter_value,
    parameter_default
from
    {{ ref('stg__parameters_in_account') }}
where True
    and  parameter_key = 'CLIENT_SESSION_KEEP_ALIVE'
    and parameter_value = True
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/parameters.html#client-session-keep-alive)

If this parameter is set to TRUE, then the session remains active indefinitely as long as the connection is active. Too many sessions created with this parameter set to true puts stress on resources and can lead to poor performance.

## How to Remediate

Change the parameter value to FALSE for the account:

```
ALTER ACCOUNT SET CLIENT_SESSION_KEEP_ALIVE = FALSE;
```