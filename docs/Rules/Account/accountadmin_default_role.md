# Accountadmin default role

## Model name

```
accountadmin_default_role
```

## Description

Avoid to set ACCOUNTADMIN as a default role.

## SQL

```
select user_id, name FROM snowflake.account_usage.users
where default_role = 'ACCOUNTADMIN';
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/security-access-control-considerations#avoid-using-the-accountadmin-role-for-automated-scripts)

> To help prevent account administrators from inadvertently using the ACCOUNTADMIN role to create objects, assign these users additional roles and designate one of these roles as their default (i.e. do not make ACCOUNTADMIN the default role for any users in the system).
> 
> This doesn’t prevent them from using the ACCOUNTADMIN role to create objects, but it forces them to explicitly change their role to ACCOUNTADMIN each time they log in. This can help make them aware of the purpose/function of roles in the system and encourage them to change to the appropriate role for performing a given task, particularly when they need to perform account administrator tasks.

## How to Remediate

Instead of massively using the ACCOUNTADMIN role, you should create role what is exactly need for that user.

Change the default role to another one:

```
ALTER USER <user_name> SET DEFAULT_ROLE = <other_role>;
```