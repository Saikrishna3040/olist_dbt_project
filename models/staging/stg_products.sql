WITH source_products AS (
    SELECT
        product_id,
        product_category_name,
        product_name_length,
        product_description_length,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    FROM {{ source('olist_raw', 'products') }}
),

categories AS (
    SELECT
        category_id,
        category_name
    FROM {{ ref('product_categories') }}
),

final AS (
    SELECT
        p.product_id,
        p.product_category_name,
        c.category_name AS category_name,
        p.product_weight_g,
        p.product_length_cm,
        p.product_height_cm,
        p.product_width_cm
    FROM source_products p
    LEFT JOIN categories c
        ON p.product_category_name = c.category_name
)

SELECT *
FROM final