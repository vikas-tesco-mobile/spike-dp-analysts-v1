{% macro assert_developer_prefix() %}
    {% if target.name == 'local' %}
        {% set prefix = var('developer_prefix') %}
        {% if prefix | trim == '' %}
            {% set err_msg = "Env variable 'DEVELOPER_PREFIX' must be set before running dbt with --target local" %}
            {% do exceptions.raise_compiler_error("❌ " ~ err_msg) %}
        {% endif %}
    {% endif %}
{% endmacro %}
