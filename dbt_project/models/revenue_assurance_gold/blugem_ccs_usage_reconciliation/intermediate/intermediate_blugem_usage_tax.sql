{{ config(materialized='view') }}

select distinct
    event_id,
    tax_code
from {{ source('vmo2_revenue_assurance_silver', 'usage_applied_tax_cleaned') }}
where event_id is not null
