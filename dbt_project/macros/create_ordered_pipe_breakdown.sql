{% macro create_ordered_pipe_breakdown(
    sort_index_expression,
    value_expression,
    rendered_value_expression="cast(x.value as string)"
) %}
    nullif(
        array_join(
            transform(
                array_sort(
                    filter(
                        collect_list(
                            named_struct(
                                'sort_index',
                                {{ sort_index_expression }},
                                'value',
                                {{ value_expression }}
                            )
                        ),
                        x -> x.value is not null
                    )
                ),
                x -> {{ rendered_value_expression }}
            ),
            '|'
        ),
        ''
    )
{% endmacro %}
