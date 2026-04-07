{{ config(materialized='view') }}

select
    root.mtx_container_name,
    root.event_id,
    root.msisdn,
    root.status_value,
    root.segment,
    root.calling_station_id,
    root.called_station_id,
    root.start_date_time,
    usage_data.usage_quantity,
    usage_data.rating_amount,
    balance.cost_amount,
    balance.cost_breakdown,
    root.role_of_node_name,
    root.service_classification,
    root.composite_usage_type,
    balance.allowance_balance,
    balance.allowance_balance_breakdown,
    balance.gross_amount_after,
    balance.gross_amount_after_breakdown,
    root.wallet_id,
    root.wallet_owner_external_id,
    root.wallet_owner_id,
    root.wallet_owner_type,
    root.unique_sequence_id,
    root.initiator_device_external_id,
    root.initiator_device_id,
    root.initiator_external_id,
    root.initiator_id,
    tax.tax_code,
    root.idd_cc_name,
    root.idd_cc_region,
    root.origination_cc_name,
    root.origination_cc_region,
    case
        when root.mtx_container_name = 'VMO2DataEvent'
            then timestampadd(
                millisecond,
                cast(coalesce(root.duration, 0) as bigint),
                root.event_datetime_utc
            )
        when root.mtx_container_name = 'VMO2VoiceEvent'
            then timestampadd(
                second,
                cast(coalesce(usage_data.usage_quantity, 0) as bigint),
                root.start_date_time
            )
        when root.mtx_container_name in ('VMO2TextEvent', 'VMO2MmsEvent')
            then root.event_datetime_utc
        else root.start_date_time
    end as end_date_time
from {{ ref('intermediate_blugem_usage_root') }} as root
left join {{ ref('intermediate_blugem_usage') }} as usage_data
    on root.event_id = usage_data.event_id
left join {{ ref('intermediate_blugem_usage_balance_agg') }} as balance
    on root.event_id = balance.event_id
left join {{ ref('intermediate_blugem_usage_tax') }} as tax
    on root.event_id = tax.event_id
