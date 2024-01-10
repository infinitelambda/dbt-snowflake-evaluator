with stg_columns as (

    select * from {{ ref('ld__account_usage__columns') }}

),

stg_tables as (

    select * from {{ ref('ld__account_usage__tables') }}

),

final as (

    select

        stg_columns.table_catalog,
        stg_columns.table_schema,
        stg_columns.table_name,
        stg_columns.ordinal_position as column_id,
        stg_columns.column_name,
        stg_columns.data_type,
        stg_columns.character_maximum_length,
        --
        stg_columns.table_name || '.' || stg_columns.column_name as drilldown_id,
        'object' as drilldown_to

    from stg_columns
    inner join stg_tables
        on (
            stg_columns.table_schema = stg_tables.table_schema
            and stg_columns.table_id = stg_tables.table_id
            and stg_tables.table_type = 'BASE TABLE'
        )

    where
        stg_columns.data_type = 'TEXT'
        and stg_columns.table_schema != 'INFORMATION_SCHEMA'
        and stg_columns.column_name ilike any ('%DATE%', '%TIME%')
        and stg_columns.deleted is null
        and stg_tables.deleted is null

    order by 1, 2, 3
)

select * from final
