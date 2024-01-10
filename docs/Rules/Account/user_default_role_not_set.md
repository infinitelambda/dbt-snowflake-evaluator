# User Default Role Not Set

## Model name

user_default_role_not_set

## Description

As a best practice, all users should have a default role which should correspond to their intended use of the Snowflake account. 

## SQL

```
SELECT user_id, name FROM snowflake.account_usage.users
WHERE True 
    and name not in ('SNOWFLAKE')
    and deleted_on is null
    and default_role is null 
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/admin-user-management)

Setting a default role for a user is important due to security as well as user's experience when working with Snowflake.

## How to Remediate

Set default role for a user using the following command:

```
ALTER USER <user_name> SET DEFAULT_ROLE = <role_name>;
```