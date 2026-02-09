{{ config(
    materialized='incremental',
    unique_key='order_item_id'
) }}

WITH orders AS (

    SELECT
        order_id,
        customer_id,
        order_purchase_timestamp
    FROM {{ ref('stg_orders') }}

),

items AS (

    SELECT
        order_id,
        product_id,
        price,
        freight_value
    FROM {{ ref('stg_order_items') }}

),

joined AS (

    SELECT
        CONCAT(o.order_id, '-', i.product_id) AS order_item_id,
        o.order_id,
        i.product_id,
        o.customer_id,
        o.order_purchase_timestamp,
        i.price,
        i.freight_value
    FROM orders o
    JOIN items i
        ON o.order_id = i.order_id

    {% if is_incremental() %}
    WHERE o.order_purchase_timestamp > (
        SELECT MAX(order_purchase_timestamp)
        FROM {{ this }}
    )
    {% endif %}

)

SELECT * FROM joined