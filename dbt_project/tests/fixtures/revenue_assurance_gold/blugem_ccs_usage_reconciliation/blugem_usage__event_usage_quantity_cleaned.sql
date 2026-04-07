select
    'VOICE' as event_type,
    'UT_EVT_001' as event_id,
    cast('2026-02-01 09:15:05' as timestamp) as event_time_utc,
    cast(0 as bigint) as usage_quantity_list_index,
    'CHARGE' as quantity_type,
    'SECOND' as quantity_unit,
    cast(0.15 as double) as usage_rating_amount,
    cast(500.0 as double) as usage_msg_amount,
    cast(0 as bigint) as flags
union all
select
    'VOICE' as event_type,
    'UT_EVT_002' as event_id,
    cast('2026-02-01 10:30:05' as timestamp) as event_time_utc,
    cast(0 as bigint) as usage_quantity_list_index,
    'CHARGE' as quantity_type,
    'SECOND' as quantity_unit,
    cast(4.25 as double) as usage_rating_amount,
    cast(15.0 as double) as usage_msg_amount,
    cast(0 as bigint) as flags
union all
select
    'DATA' as event_type,
    'UT_EVT_003' as event_id,
    cast('2026-02-01 11:00:01' as timestamp) as event_time_utc,
    cast(0 as bigint) as usage_quantity_list_index,
    'DATA_VOLUME' as quantity_type,
    'BYTE' as quantity_unit,
    cast(0.00 as double) as usage_rating_amount,
    cast(94371840.0 as double) as usage_msg_amount,
    cast(0 as bigint) as flags
union all
select
    'TEXT' as event_type,
    'UT_EVT_004' as event_id,
    cast('2026-02-01 12:00:01' as timestamp) as event_time_utc,
    cast(0 as bigint) as usage_quantity_list_index,
    'MESSAGE' as quantity_type,
    'COUNT' as quantity_unit,
    cast(0.25 as double) as usage_rating_amount,
    cast(1.0 as double) as usage_msg_amount,
    cast(0 as bigint) as flags
union all
select
    'MMS' as event_type,
    'UT_EVT_005' as event_id,
    cast('2026-02-01 13:00:01' as timestamp) as event_time_utc,
    cast(0 as bigint) as usage_quantity_list_index,
    'MESSAGE' as quantity_type,
    'COUNT' as quantity_unit,
    cast(0.50 as double) as usage_rating_amount,
    cast(1.0 as double) as usage_msg_amount,
    cast(0 as bigint) as flags
