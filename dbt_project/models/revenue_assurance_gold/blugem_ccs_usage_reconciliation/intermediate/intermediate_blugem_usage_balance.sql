{{ config(materialized='view') }}

select
    event_id,
    balance_update_array_index,
    balance_class_id,
    case when balance_class_id = 826 then balance_amount end as cost_value,
    case
        when balance_class_id in (20007, 20006, 20003) then balance_amount
    end as allowance_balance_value,
    case
        when balance_class_id in (20007, 20006, 20003) then gross_amount_after
    end as gross_amount_after_value
from {{ source('vmo2_revenue_assurance_silver', 'usage_balance_update_cleaned') }}
where event_id is not null
