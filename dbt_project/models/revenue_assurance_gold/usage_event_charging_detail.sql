{{ config(materialized='table') }}


SELECT
    usage_root.event_id,
    usage_root.event_type,
    usage_root.event_datetime_utc,
    usage_root.aggregation_id,
    usage_root.msisdn,
    usage_root.called_station_id,
    usage_root.calling_station_id,
    usage_root.call_answer_time,
    usage_root.idd_cc_name,
    usage_root.idd_cc_region,
    usage_root.origination_cc_name,
    usage_root.origination_cc_region,
    usage_root.role_of_node,
    usage_root.role_of_node_name,
    usage_root.service_classification,
    usage_root.composite_usage_type,
    usage_quantity.usage_msg_amount,
    usage_quantity.usage_rating_amount,
    balance_update.balance_class_id,
    balance_update.balance_amount

FROM
    {{ source('vmo2_revenue_assurance_silver', 'usage_root_cleaned') }}
        AS usage_root
INNER JOIN
    {{ source('vmo2_revenue_assurance_silver', 'usage_quantity_cleaned') }}
        AS usage_quantity
    ON usage_root.event_id = usage_quantity.event_id
INNER JOIN
    {{ source('vmo2_revenue_assurance_silver', 'usage_balance_update_cleaned') }}
        AS balance_update
    ON usage_root.event_id = balance_update.event_id
