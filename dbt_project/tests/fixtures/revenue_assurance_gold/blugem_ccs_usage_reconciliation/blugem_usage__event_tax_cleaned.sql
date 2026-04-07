select
    'VOICE' as event_type,
    'UT_EVT_001' as event_id,
    cast('2026-02-01 09:15:15' as timestamp) as event_time_utc,
    cast(0 as bigint) as applied_tax_array_index,
    '20' as tax_code
union all
select
    'VOICE' as event_type,
    'UT_EVT_002' as event_id,
    cast('2026-02-01 10:30:12' as timestamp) as event_time_utc,
    cast(0 as bigint) as applied_tax_array_index,
    '99' as tax_code
union all
select
    'DATA' as event_type,
    'UT_EVT_003' as event_id,
    cast('2026-02-01 11:00:03' as timestamp) as event_time_utc,
    cast(0 as bigint) as applied_tax_array_index,
    '30' as tax_code
union all
select
    'TEXT' as event_type,
    'UT_EVT_004' as event_id,
    cast('2026-02-01 12:00:03' as timestamp) as event_time_utc,
    cast(0 as bigint) as applied_tax_array_index,
    '40' as tax_code
union all
select
    'MMS' as event_type,
    'UT_EVT_005' as event_id,
    cast('2026-02-01 13:00:03' as timestamp) as event_time_utc,
    cast(0 as bigint) as applied_tax_array_index,
    '50' as tax_code
