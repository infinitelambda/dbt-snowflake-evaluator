# User Inactive

## Model name

user_inactive

## Description

ACCOUNT_USAGE view allows to get detailed info for users and their activity in the Snowflake account. 

## SQL

```
SELECT user_id, name, last_success_login FROM snowflake.account_usage.users
WHERE True 
    and name not in ('SNOWFLAKE')
    and deleted_on is null 
and last_success_login < DATEADD(DAY, -90, CURRENT_TIMESTAMP()) -- haven’t used Snowflake in the last 90 days)
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/account-usage)

If some users have not been active for a very long time, it might be worth considering to disable or drop them.

## How to Remediate

Drop the user using the following command:

```
DROP USER <user_name>;
```