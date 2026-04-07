with numeric_input as (
    select
        cast(2 as bigint) as sort_index,
        cast(4.56 as double) as breakdown_value
    union all
    select
        cast(3 as bigint) as sort_index,
        cast(null as double) as breakdown_value
    union all
    select
        cast(1 as bigint) as sort_index,
        cast(1.23 as double) as breakdown_value
),

numeric_actual as (
    select
        {{
            create_ordered_pipe_breakdown(
                'sort_index',
                'breakdown_value',
                "format_string('%.6f', x.value)"
            )
        }} as actual_value
    from numeric_input
),

string_input as (
    select
        cast(3 as bigint) as sort_index,
        cast('gamma' as string) as breakdown_value
    union all
    select
        cast(1 as bigint) as sort_index,
        cast('alpha' as string) as breakdown_value
    union all
    select
        cast(2 as bigint) as sort_index,
        cast(null as string) as breakdown_value
),

string_actual as (
    select
        {{
            create_ordered_pipe_breakdown(
                'sort_index',
                'breakdown_value'
            )
        }} as actual_value
    from string_input
),

failures as (
    select
        'numeric_formatting' as assertion_name,
        actual_value,
        '1.230000|4.560000' as expected_value
    from numeric_actual
    where actual_value != '1.230000|4.560000'

    union all

    select
        'string_rendering' as assertion_name,
        actual_value,
        'alpha|gamma' as expected_value
    from string_actual
    where actual_value != 'alpha|gamma'
)

select *
from failures
