# Accountadmin Created Objects

## Model name

accountadmin_created_objects

## Description

Avoid Using the ACCOUNTADMIN Role to Create Objects.

## SQL

```
select * 
from snowflake.account_usage.grants_to_roles 
where deleted_on is null
and granted_to = 'ROLE' 
and grantee_name = 'ACCOUNTADMIN'
and granted_by = 'ACCOUNTADMIN'
and privilege = 'OWNERSHIP'
and granted_on not in (
    'INTEGRATION',
    'RESOURCE MONITOR',
    'SHARE',
    'NOTIFICATION SUBSCRIPTION',
    'MANAGED ACCOUNT'
);
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/security-access-control-considerations#avoid-using-the-accountadmin-role-to-create-objects)

> The ACCOUNTADMIN role is intended for performing initial setup tasks in the system and managing account-level objects and tasks on a day-to-day basis. As such, it should not be used to create objects in your account, unless you absolutely need these objects to have the highest level of secure access. If you create objects with the ACCOUNTADMIN role and you want users to have access to these objects, you must explicitly grant privileges on the objects to the roles for these users.
> 
> Instead, we recommend creating a hierarchy of roles aligned with business functions in your organization and ultimately assigning these roles to the SYSADMIN role. For more information, see Aligning Object Access with Business Functions in this topic.

## How to Remediate

There should be a hierarchy of roles aligned with business functions in your organization, which are assigned to the SYSADMIN role. See [Aligning Object Access with Business Function](https://docs.snowflake.com/en/user-guide/security-access-control-considerations#aligning-object-access-with-business-functions) for more information on this topic.

Determine the appropriate roles to own the objects previously created by ACCOUNTADMIN, and reassign the OWNERSHIP privilege to them using the [GRANT OWNERSHIP](https://docs.snowflake.com/en/sql-reference/sql/grant-ownership) command. For example:

```
GRANT OWNERSHIP ON SCHEMA marketing TO ROLE marketing_r;
```

**Note:** It will take up to 2h for the changes in ownership to be reflected in the dbt models.