# Custom Roles Granted to Sysadmin

## Model name

custom_roles_granted_to_sysadmin

## Description

As a Snowflake best practice, functional roles in a role hierarchy should be granted to the system administrator (SYSADMIN) role. System administrators can then grant privileges on database objects to any roles in this hierarchy.

## SQL

```
SHOW ROLES;
```

## Reason to flag

This may indicate a problem with the role hierarchy. System administrators is not able to perform some tasks or actions corresponding to their role.

## How to Remediate

Grant custom role to SYSADMIN role:

```
GRANT ROLE <role_name> TO ROLE SYSADMIN;
```