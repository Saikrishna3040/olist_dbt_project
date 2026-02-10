{{ config(materialized='view'
) }}

SELECT
    order_id,
    payment_type,
    payment_value
FROM {{ ref('stg_payments') }}
WHERE payment_type IN (
{% for m in var('payment_methods') %}
    '{{ m }}'{% if not loop.last %},{% endif %}
{% endfor %}
)