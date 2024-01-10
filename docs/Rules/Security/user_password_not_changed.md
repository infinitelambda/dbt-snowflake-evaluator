# User Password Not Changed

## Model name

user_password_not_changed

## Description

ACCOUNT_USAGE view allows to get detailed info for users and their activity in the Snowflake account. As a best practice, users should change their Snowflake password regularly. This rule allows to identify users who haven't changed their password for a specified time period (e.g. 180 days).

## SQL

```
SELECT user_id, name, has_password, password_last_set_time FROM snowflake.account_usage.users
WHERE True 
    and name not in ('SNOWFLAKE')
    and deleted_on is null
and has_password = TRUE AND password_last_set_time < DATEADD(DAY, -180, CURRENT_TIMESTAMP()) -- hasn’t changed in the last 180 days)
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/account-usage)

It might be worth considering to force a password change for users that don't change their password regularly.

## How to Remediate

Set MUST_CHANGE_PASSWORD user parameter to TRUE:

```
ALTER USER <user_name> SET MUST_CHANGE_PASSWORD = TRUE;
```