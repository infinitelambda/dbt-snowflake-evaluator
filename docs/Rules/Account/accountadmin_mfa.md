# Accountadmin MFA

## Model name

accountadmin_mfa

## Description

All users assigned the ACCOUNTADMIN role should also be required to use multi-factor authentication (MFA) for login

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
and ext_authn_duo = false;
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/security-mfa)

> At a minimum, Snowflake strongly recommends that all users with the ACCOUNTADMIN role be required to use MFA.

## How to Remediate

Follow the guides described in the [Snowflake Documentation](https://docs.snowflake.com/en/user-guide/security-mfa).