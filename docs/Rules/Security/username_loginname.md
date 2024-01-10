

## Model name

```
username_loginname
```

## Description

As a best practice, username and login name values should be different for all users.

## SQL

```
SELECT user_id, name, login_name FROM snowflake.account_usage.users
WHERE name = login_name;
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/sql-reference/functions/all_user_names)

The rule that username and login name for a user is different increases account security.

## How to Remediate

To update existing username or login name values, execute the ALTER USER command. When creating new users with the CREATE USER command, ensure that the NAME and LOGIN_NAME values are different.

```
ALTER USER <user_name> SET LOGIN_NAME = <string>;
CREATE USER <user_name> LOGIN_NAME = <string>;
```