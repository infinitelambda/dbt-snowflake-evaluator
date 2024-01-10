# User Default Warehouse Not Set

## Model name

user_default_warehouse_not_set

## Description

As a best practice, all users should have a default warehouse which should correspond to their intended use of the Snowflake account. 

## SQL

```
SELECT user_id, name FROM snowflake.account_usage.users
WHERE True 
    and name not in ('SNOWFLAKE')
    and deleted_on is null
    and default_warehouse is null
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/admin-user-management)

Setting a default warehouse for a user is important due to security as well as user's experience when working with Snowflake.

## How to Remediate

Set default warehouse for a user using the following command:

```
ALTER USER <user_name> SET DEFAULT_WAREHOUSE = <warehouse_name>;
```