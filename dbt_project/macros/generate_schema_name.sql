{% macro generate_schema_name(custom_schema_name, node) %}
    {%- set prefix = var('developer_prefix') -%}
    {%- set schema_name = node.path.split('/')[0] -%}
    {%- if target.name == 'local' and prefix | length > 0 -%}
        {%- set schema_name = prefix ~ '_' ~ schema_name -%}
    {%- endif -%}
    {{ schema_name }}
{% endmacro %}
