SELECT
    order_id,
    product_id,
    price,
    freight_value
FROM {{ source('olist_raw', 'order_items') }}