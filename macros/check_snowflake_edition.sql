{% macro check_snowflake_edition(edition) %}

    {% if edition == 'Enterprise' and var('snowflake_edition') in ('Enterprise', 'Business Critical','Virtual Private Snowflake') %}
        {% do return(True) %}
    {% elif edition == 'Business Critical' and var('snowflake_edition') in ('Business Critical','Virtual Private Snowflake') %}
        {% do return(True) %}
    {% elif edition == 'Virtual Private Snowflake' and var('snowflake_edition') in ('Virtual Private Snowflake') %}
        {% do return(True) %}
    {% else %}
        {% do return(False) %}
    {% endif %}

{% endmacro %}