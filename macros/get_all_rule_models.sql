{% macro get_all_rule_models() %}
    {% if execute %}
        {% set rule_models = [] %}

        {% for model in graph.nodes.values() | selectattr("resource_type", "equalto", "model") %}
            {% if model.name.startswith('rule_') %}
                
                {% do rule_models.append({"model": model.name, "description": model.get("description"), "meta": model.get("meta")}) %}

            {% endif %}
        {% endfor %}
        
        {{ return(rule_models) }}

    {% endif %}
{% endmacro %}