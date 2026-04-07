{{ config(materialized='table') }}

WITH usage_root AS (
    SELECT *
    FROM
        {{ source('vmo2_revenue_assurance_silver', 'usage_root_cleaned') }}
),

usage_balance AS (
    SELECT *
    FROM
        {{ source('vmo2_revenue_assurance_silver', 'usage_balance_update_cleaned') }}
),

usage_quantity AS (
    SELECT *
    FROM
        {{ source('vmo2_revenue_assurance_silver', 'usage_quantity_cleaned') }}
),

numbered_balances AS (
    SELECT
        b.event_id,
        b.balance_class_id,
        b.balance_amount,
        ROW_NUMBER()
            OVER (PARTITION BY b.event_id ORDER BY b.balance_class_id)
            AS rn
    FROM usage_balance AS b
    WHERE
        b.event_id IS NOT NULL
        AND b.balance_class_id IS NOT NULL
),

numbered_usage AS (
    SELECT
        u.event_id,
        u.usage_msg_amount,
        u.usage_rating_amount,
        ROW_NUMBER()
            OVER (PARTITION BY u.event_id ORDER BY u.usage_rating_amount)
            AS rn
    FROM usage_quantity AS u
    WHERE
        u.event_id IS NOT NULL
        AND u.usage_rating_amount IS NOT NULL
)

SELECT
    r.event_type,
    r.event_id,
    r.event_datetime_utc,
    r.aggregation_id,
    r.msisdn,
    r.called_station_id,
    r.calling_station_id,
    r.call_answer_time,
    r.idd_cc_name,
    r.idd_cc_region,
    r.origination_cc_name,
    r.origination_cc_region,
    r.role_of_node,
    r.role_of_node_name,
    r.service_classification,
    r.composite_usage_type,
    MAX(
        CASE
            WHEN b.rn = 1 THEN b.balance_class_id
        END
    ) AS balance_class_id_1,
    MAX(
        CASE
            WHEN b.rn = 1 THEN b.balance_amount
        END
    ) AS balance_amount_1,
    MAX(
        CASE
            WHEN b.rn = 2 THEN b.balance_class_id
        END
    ) AS balance_class_id_2,
    MAX(
        CASE
            WHEN b.rn = 2 THEN b.balance_amount
        END
    ) AS balance_amount_2,
    MAX(
        CASE
            WHEN b.rn = 3 THEN b.balance_class_id
        END
    ) AS balance_class_id_3,
    MAX(
        CASE
            WHEN b.rn = 3 THEN b.balance_amount
        END
    ) AS balance_amount_3,
    MAX(
        CASE
            WHEN u.rn = 1 THEN u.usage_msg_amount
        END
    ) AS usage_msg_amount_1,
    MAX(
        CASE
            WHEN u.rn = 1 THEN u.usage_rating_amount
        END
    ) AS usage_rating_amount_1
FROM
    usage_root AS r
LEFT JOIN numbered_balances AS b ON r.event_id = b.event_id
LEFT JOIN numbered_usage AS u ON r.event_id = u.event_id
GROUP BY
    r.event_type,
    r.event_id,
    r.event_datetime_utc,
    r.aggregation_id,
    r.msisdn,
    r.called_station_id,
    r.calling_station_id,
    r.call_answer_time,
    r.idd_cc_name,
    r.idd_cc_region,
    r.origination_cc_name,
    r.origination_cc_region,
    r.role_of_node,
    r.role_of_node_name,
    r.service_classification,
    r.composite_usage_type
