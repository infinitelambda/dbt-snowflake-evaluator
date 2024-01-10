{% set rule_models = get_all_rule_models() -%}

{%- for rule in rule_models -%}
    {{ query_rule_result_summary(rule.model, rule.description,
                                rule.meta.get("title"),
                                rule.meta.get("doclink"),
                                rule.meta.get("category"),
                                rule.meta.get("doc_section")) }}
    {%- if not loop.last %}
        union all
    {% endif -%}
{% endfor %}
