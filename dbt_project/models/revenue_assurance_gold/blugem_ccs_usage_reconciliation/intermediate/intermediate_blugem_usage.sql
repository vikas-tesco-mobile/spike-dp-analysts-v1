{{ config(materialized='view') }}

select distinct
    event_id,
    cast(round(usage_msg_amount, 6) as decimal(38, 6)) as usage_quantity,
    cast(round(usage_rating_amount, 6) as decimal(38, 6)) as rating_amount
from {{ source('vmo2_revenue_assurance_silver', 'usage_quantity_cleaned') }}
where event_id is not null
