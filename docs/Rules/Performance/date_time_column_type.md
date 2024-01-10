# Date Time Column Type

## Model name

date_time_column_type

## Description

When defining columns to contain dates or timestamps, Snowflake recommends choosing a date or timestamp data type rather than a character data type. Snowflake stores DATE and TIMESTAMP data more efficiently than VARCHAR, resulting in better query performance. Choose an appropriate date or timestamp data type, depending on the level of granularity required. 

## SQL

```
with stg_columns as (

    select * from {{ ref('stg__account_usage__columns') }}

),

stg_tables as (

    select * from {{ ref('stg__account_usage__tables') }}

),

final as (

    select 

        stg_columns.table_catalog,
        stg_columns.table_schema,
        stg_columns.table_name,
        stg_columns.ordinal_position as column_id,
        stg_columns.column_name,
        stg_columns.data_type,
        stg_columns.character_maximum_length

    from stg_columns
    join stg_tables
        on (stg_tables.table_schema = stg_columns.table_schema
            and stg_tables.table_id = stg_columns.table_id
            and stg_tables.table_type = 'BASE TABLE'
            )

    where stg_columns.data_type = 'TEXT'
        and stg_columns.table_schema != 'INFORMATION_SCHEMA'
        and stg_columns.column_name ILIKE ANY ('%DATE%', '%TIME%')
        and stg_columns.deleted is null
        and stg_tables.deleted is null
    
    order by 1, 2, 3
)

select * from final
```

## Reason to flag

[Snowflake Docs](https://docs.snowflake.com/en/user-guide/table-considerations)

To prevent data type-related issues with dates and timestamps and improve performance.

## How to Remediate

It is not directly possible to change the data type in a table, one of the options is to try the following workaround:

1. Add a new column with a temp name, with the new data type
2. Run an update statement to set the new column to the old column's value (with any required transformations)
3. Rename the columns, and drop the old column if desired.

```
ALTER TABLE <TABLE_NAME> ADD COLUMN <COLUMN_NAME_TEMP> DATE;
UPDATE <TABLE_NAME> SET <COLUMN_NAME_TEMP> = TO_DATE(<COLUMN_NAME>);
ALTER TABLE <TABLE_NAME> DROP COLUMN <COLUMN_NAME>;
ALTER TABLE <TABLE_NAME> RENAME COLUMN <COLUMN_NAME_TEMP> to <COLUMN_NAME>;
```