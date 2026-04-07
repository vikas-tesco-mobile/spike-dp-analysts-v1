select
    'UT_EVT_001' as event_id,
    cast(1.05 as decimal(38, 6)) as cost_amount,
    cast(257.0 as decimal(38, 6)) as allowance_balance,
    cast(458.0 as decimal(38, 6)) as gross_amount_after,
    '0.150000|0.200000|0.300000|0.400000' as cost_breakdown,
    '215.000000|25.000000|10.000000|5.000000|2.000000' as allowance_balance_breakdown,
    '0.000000|125.000000|115.000000|110.000000|108.000000' as gross_amount_after_breakdown
union all
select
    'UT_EVT_002' as event_id,
    cast(4.25 as decimal(38, 6)) as cost_amount,
    cast(null as decimal(38, 6)) as allowance_balance,
    cast(null as decimal(38, 6)) as gross_amount_after,
    '4.250000' as cost_breakdown,
    cast(null as string) as allowance_balance_breakdown,
    cast(null as string) as gross_amount_after_breakdown
union all
select
    'UT_EVT_003' as event_id,
    cast(1.25 as decimal(38, 6)) as cost_amount,
    cast(null as decimal(38, 6)) as allowance_balance,
    cast(null as decimal(38, 6)) as gross_amount_after,
    '1.250000' as cost_breakdown,
    cast(null as string) as allowance_balance_breakdown,
    cast(null as string) as gross_amount_after_breakdown
union all
select
    'UT_EVT_004' as event_id,
    cast(0.25 as decimal(38, 6)) as cost_amount,
    cast(null as decimal(38, 6)) as allowance_balance,
    cast(null as decimal(38, 6)) as gross_amount_after,
    '0.250000' as cost_breakdown,
    cast(null as string) as allowance_balance_breakdown,
    cast(null as string) as gross_amount_after_breakdown
union all
select
    'UT_EVT_005' as event_id,
    cast(0.50 as decimal(38, 6)) as cost_amount,
    cast(null as decimal(38, 6)) as allowance_balance,
    cast(null as decimal(38, 6)) as gross_amount_after,
    '0.500000' as cost_breakdown,
    cast(null as string) as allowance_balance_breakdown,
    cast(null as string) as gross_amount_after_breakdown
