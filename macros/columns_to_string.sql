{% macro columns_to_string(column_names) %}

    {% for column_name in column_names %}
        ifnull(to_char({{ column_name }}), '~~')
        {%- if not loop.last %}
            ||'_'||
        {% endif -%}
    {% endfor %}

{% endmacro %}