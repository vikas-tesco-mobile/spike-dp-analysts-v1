{{ config(materialized='table') }}

with usage_root as (
    select
        event_id,
        event_type,
        event_datetime_utc,
        aggregation_id,
        msisdn,
        idd_cc_name,
        idd_cc_region,
        origination_cc_name,
        origination_cc_region,
        service_classification
    from {{ source('vmo2_revenue_assurance_silver', 'usage_root_cleaned') }}
),

usage_tax as (
    select
        event_id,
        tax_code,
        tax_name,
        tax_rate,
        external_id
    from {{ source('vmo2_revenue_assurance_silver', 'usage_applied_tax_cleaned') }}
    where tax_code = '20'
),

usage_balance as (
    select
        event_id,
        balance_class_id,
        balance_amount
    from {{ source('vmo2_revenue_assurance_silver', 'usage_balance_update_cleaned') }}
    where balance_class_id = 826
),

agg_tax_code_balance as (
    select
        usage_root.event_type,
        usage_root.aggregation_id,
        usage_root.msisdn,
        usage_root.idd_cc_name,
        usage_root.idd_cc_region,
        usage_root.origination_cc_name,
        usage_root.origination_cc_region,
        usage_root.service_classification,
        usage_tax.tax_code,
        usage_tax.tax_name,
        usage_tax.tax_rate,
        usage_tax.external_id,
        usage_balance.balance_class_id,
        to_date(usage_root.event_datetime_utc) as event_date,
        sum(usage_balance.balance_amount) as spend_amount
    from usage_root
    inner join usage_tax on usage_root.event_id = usage_tax.event_id
    inner join usage_balance on usage_root.event_id = usage_balance.event_id
    group by
        usage_root.event_type,
        to_date(usage_root.event_datetime_utc),
        usage_root.aggregation_id,
        usage_root.msisdn,
        usage_root.idd_cc_name,
        usage_root.idd_cc_region,
        usage_root.origination_cc_name,
        usage_root.origination_cc_region,
        usage_root.service_classification,
        usage_tax.tax_code,
        usage_tax.tax_name,
        usage_tax.tax_rate,
        usage_tax.external_id,
        usage_balance.balance_class_id
)

select * from agg_tax_code_balance
