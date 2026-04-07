select
    'UT_EVT_001' as event_id,
    cast(500.0 as decimal(38, 6)) as usage_quantity,
    cast(0.15 as decimal(38, 6)) as rating_amount
union all
select
    'UT_EVT_002' as event_id,
    cast(15.0 as decimal(38, 6)) as usage_quantity,
    cast(4.25 as decimal(38, 6)) as rating_amount
union all
select
    'UT_EVT_003' as event_id,
    cast(94371840.0 as decimal(38, 6)) as usage_quantity,
    cast(0.0 as decimal(38, 6)) as rating_amount
union all
select
    'UT_EVT_004' as event_id,
    cast(1.0 as decimal(38, 6)) as usage_quantity,
    cast(0.25 as decimal(38, 6)) as rating_amount
union all
select
    'UT_EVT_005' as event_id,
    cast(1.0 as decimal(38, 6)) as usage_quantity,
    cast(0.50 as decimal(38, 6)) as rating_amount
