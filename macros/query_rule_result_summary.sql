{% macro query_rule_result_summary(model_name, model_description, model_title,  model_doclink,  model_category, model_doc_section) %}
    select 
          '{{ model_name | as_text }}' as rule_id
        , '{{ model_category | upper }}' as rule_category
        , '{{ model_title | replace("'", "''") }}' as rule_name
        , '{{ model_description | replace("'", "''") }}' as rule_description
        , '{{ "[See the doc for the rule reference](" ~ var("doc_site") ~ "/" ~ model_doc_section ~ "/" ~ model_name[5:] ~ ")" }}' as rule_doclink
        , iff(cnt_rule_violations = 0, 'PASS', 'FAIL') as rule_status
        , identifiers
        --
        , cnt_rule_violations
        , sysdate() as __inserted_at
    from (
        select 
            coalesce(count(1), 0) as cnt_rule_violations
            , listagg(drilldown_id, ',') as identifiers
        from {{ model_name }}
    ) as {{model_name}}_result
{% endmacro %}