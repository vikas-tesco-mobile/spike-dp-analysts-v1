{{ config(materialized='view') }}

select
    mtx_container_name,
    event_id,
    event_datetime_utc,
    duration,
    msisdn,
    status_value,
    segment,
    calling_station_id,
    called_station_id,
    idd_cc_name,
    idd_cc_region,
    origination_cc_name,
    origination_cc_region,
    role_of_node_name,
    service_classification,
    composite_usage_type,
    wallet_id,
    wallet_owner_external_id,
    wallet_owner_id,
    wallet_owner_type,
    unique_sequence_id,
    initiator_device_external_id,
    initiator_device_id,
    initiator_external_id,
    initiator_id,
    case
        when mtx_container_name = 'VMO2VoiceEvent'
            then coalesce(cast(call_answer_time as timestamp), event_datetime_utc)
        else event_datetime_utc
    end as start_date_time
from {{ source('vmo2_revenue_assurance_silver', 'usage_root_cleaned') }}
where event_id is not null
