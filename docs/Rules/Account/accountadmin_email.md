# Accountadmin should have email address

## Model name

```
accountadmin_email
```

## Description

ACCOUNTADMIN user(s) should have email addresses, in case of Snowflake Support needs to contact with the client.

## SQL

```
select
    u.name
    , u.login_name
from snowflake.account_usage.grants_to_users as ug
join snowflake.account_usage.users as u 
  on u.name = ug.grantee_name
where ug.deleted_on is null
and u.deleted_on is null
and ug.role = 'ACCOUNTADMIN'
and email is null;
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/security-access-control-considerations#control-the-assignment-of-the-accountadmin-role-to-users)

> It also helps if you associate an actual person’s email address to ACCOUNTADMIN users, so that Snowflake Support knows who to contact in an urgent situation.

## How to Remediate

For all user that assigned ACCOUNTADMIN role, they should have email address.

Assign email address to user:

```
ALTER USER <user_name> SET EMAIL = <user_email>;
```