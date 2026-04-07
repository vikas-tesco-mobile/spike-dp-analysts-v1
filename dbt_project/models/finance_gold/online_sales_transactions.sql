{{ config(
    materialized = 'table'
) }}

with online_sales as (
    select
        'ONLINE' as transaction_source,
        sale_identifier as transaction_number,
        cust_order_number,
        transaction_type,
        order_date,
        dispatch_date,
        header_date,
        sales_value,
        discount_value,
        scanned_sales_qty,
        return_reason_code,
        base_product_number,
        long_description,
        product_sub_group_code,
        lpad(cast(base_product_number as string), 9, '0') as tpnb
    from {{ source('tesco_finance_silver_schema', 'tap_online_sales_cleaned') }}
),

products as (
    select
        product_id,
        tpnb,
        gtin,
        tpna,
        tpnc,
        description as product_description,
        brand,
        subclass_code,
        subclass_name
    from {{ source('tesco_finance_silver_schema', 'tesco_products_cleaned') }}
)

select
    s.transaction_source,
    s.transaction_number,
    s.cust_order_number as order_number,
    s.transaction_type,
    s.order_date,
    s.dispatch_date,
    s.header_date,
    s.tpnb,
    p.product_id,
    p.gtin,
    p.tpna,
    p.tpnc,
    p.product_description,
    p.brand,
    p.subclass_code,
    p.subclass_name,
    s.sales_value as price_after_discount_amount,
    s.scanned_sales_qty as number_of_units,
    s.return_reason_code,
    'missing mapping' as order_id,
    'missing mapping' as location_id,
    'missing mapping' as fulfilment_date,
    'missing mapping' as checked_out_date,
    'missing mapping' as return_date,
    'missing mapping' as unit_of_measure,
    'missing mapping' as net_amount,
    'missing mapping' as refund_amount,
    'missing mapping' as colleague_discount_amount,
    'missing mapping' as coupon_discount_amount,
    'missing mapping' as multisaver_discount_amount,
    'missing mapping' as price_cut_discount_amount,
    'missing mapping' as multibuy_promo_description,
    'missing mapping' as invoice_id,
    'missing mapping' as customer_id,
    'missing mapping' as tax_band,
    'missing mapping' as vat_amount,
    'missing mapping' as debit_credit,
    'missing mapping' as apportioned_earned_points,
    'missing mapping' as reduced_to_clear,
    (coalesce(s.sales_value, 0) + coalesce(s.discount_value, 0)) as price_before_discount_amount

from online_sales as s
left join products as p
    on s.tpnb = p.tpnb
