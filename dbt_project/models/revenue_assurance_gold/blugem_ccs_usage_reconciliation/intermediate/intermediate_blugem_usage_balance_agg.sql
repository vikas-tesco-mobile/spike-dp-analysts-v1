{{ config(materialized='view') }}

select
    event_id,
    cast(round(sum(cost_value), 6) as decimal(38, 6)) as cost_amount,
    cast(round(sum(allowance_balance_value), 6) as decimal(38, 6)) as allowance_balance,
    cast(round(sum(gross_amount_after_value), 6) as decimal(38, 6)) as gross_amount_after,
    {{
        create_ordered_pipe_breakdown(
            'balance_update_array_index',
            'cost_value',
            "format_string('%.6f', x.value)"
        )
    }} as cost_breakdown,
    {{
        create_ordered_pipe_breakdown(
            'balance_update_array_index',
            'allowance_balance_value',
            "format_string('%.6f', x.value)"
        )
    }} as allowance_balance_breakdown,
    {{
        create_ordered_pipe_breakdown(
            'balance_update_array_index',
            'gross_amount_after_value',
            "format_string('%.6f', x.value)"
        )
    }} as gross_amount_after_breakdown
from {{ ref('intermediate_blugem_usage_balance') }}
group by event_id
