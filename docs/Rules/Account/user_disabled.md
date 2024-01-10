# User Disabled

## Model name

user_disabled

## Description

ACCOUNT_USAGE view allows to get detailed info for users and their activity in the Snowflake account. 

## SQL

```
SELECT user_id, name FROM snowflake.account_usage.users
WHERE True 
    and name not in ('SNOWFLAKE')
    and deleted_on is null
 and disabled = TRUE;
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/account-usage)

It might be worth considering to drop or re-enable users which have been disabled for a long time. 

## How to Remediate

Drop or re-enable the user using one of the following command:

```
DROP USER <user_name>;
ALTER USER <user_name> SET DISABLED = FALSE;
```