# Warehouse Cloud Service Billing Threshold

## Model name

warehouse_cloud_service_billing_threshold

## Description

Overall for an account (and outside of serverless features), Snowflake will charge for cloud services only if they exceed 10% of the daily virtual warehouse credit consumption. The aim of this rule is to identify the warehouses which are contributing to the cloud service compute costs.

## SQL

```
select

  warehouse_name,
  SUM(credits_used) AS credits_used,
  SUM(credits_used_cloud_services) AS credits_used_cloud_services,
  SUM(credits_used_cloud_services)/SUM(credits_used) AS percent_cloud_services

from {{ ref('stg__warehouse_metering_history') }}

where TO_DATE(start_time) >= DATEADD(month, -1, CURRENT_TIMESTAMP())
    and credits_used_cloud_services > 0
group by 1
having percent_cloud_services >= 0.1
order by 4 desc
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/cost-exploring-compute)

Identification of the warehouses that are not using enough warehouse time to cover the cloud services portion of compute provides a launching point for additional investigation by isolating warehouses with a high ratio of cloud service use (>10% of overall credits). Investigation candidates include issues around cloning, listing files in S3, partner tools, setting session parameters, etc.

## How to Remediate

It's recommended to take a more detailed look at the affected warehouses.

```
```