{% test assert_single_value_per_group(model, key_column, value_columns) %}
    select
        {{ key_column }}
    from {{ model }}
    group by {{ key_column }}
    having
        {% for column_name in value_columns %}
            count({{ column_name }}) > 1
            {% if not loop.last %}or{% endif %}
        {% endfor %}
{% endtest %}
