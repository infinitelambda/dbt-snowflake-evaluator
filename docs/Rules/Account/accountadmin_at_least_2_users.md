# Accountadmin at Least 2 Users

## Model name

accountadmin_at_least_2_users

## Description

Assign ACCOUNTADMIN role at least two users.

## SQL

```
-- Show the ACCOUNTADMIN role and see how many users are assigned to it
SHOW ROLES like 'ACCOUNTADMIN';
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/security-access-control-considerations#control-the-assignment-of-the-accountadmin-role-to-users)

> Assign this role to at least two users. We follow strict security procedures for resetting a forgotten or lost password for users with the ACCOUNTADMIN role. These procedures can take up to two business days. Assigning the ACCOUNTADMIN role to more than one user avoids having to go through these procedures because the users can reset each other’s passwords.

## How to Remediate

Grant ACCOUNTADMIN permission to another user:

```
USE ROLE ACCOUNTADMIN;
GRANT ROLE ACCOUNTADMIN to user <user_name>;
```