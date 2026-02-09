WITH orders AS (

    SELECT *
    FROM {{ ref('stg_orders') }}

),

customers AS (

    SELECT *
    FROM {{ ref('stg_customers') }}

)

SELECT
    o.order_id,
    o.customer_id,
    c.customer_city,
    o.order_status
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id