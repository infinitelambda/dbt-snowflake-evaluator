{% test accepted_value(model, column_name, upperlimit) %}

    {{ config (
        severity = 'warn',
        fail_calc = "n_records"
    ) }}

    select count(*) as n_records
    from {{ model }}
    where {{ column_name }} > {{ upperlimit }}

{% endtest %}