# Network Restrict Access

## Model name

network_restrict_access

## Description

By default, Snowflake allows users to connect to the service from any computer or device IP address. As a system administrator you can allow and deny access from addresses with network policies.

## SQL

```
-- Lists all network policies defined in the system
SHOW NETWORK POLICIES;

-- Describes the properties specified for a network policy
DESC[RIBE] NETWORK POLICY <name>;
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/network-policies)

> Network policies allow restricting access to your account based on user IP address. Effectively, a network policy enables you to create an IP allowed list, as well as an IP blocked list, if desired.

## How to Remediate

Check the necessary steps on the Snowflake documentation page mentioned above.

Use network policies to allow “known” client locations (IP ranges) to connect to your Snowflake account while blocking others.

Don't forget to whitelist the other services you use, like dbtCloud or Fivetran. 
Regarding dbtCloud check their [documentation](https://docs.getdbt.com/docs/cloud/about-cloud/regions-ip-addresses) for the exact IP ranges.