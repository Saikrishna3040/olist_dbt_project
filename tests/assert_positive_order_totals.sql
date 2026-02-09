WITH order_totals AS (
    SELECT
        oi.order_id,
        SUM(oi.price + oi.freight_value) AS order_total
    FROM {{ ref('stg_order_items') }} oi
    GROUP BY oi.order_id
)

SELECT
    order_id,
    order_total
FROM order_totals
WHERE order_total <= 0