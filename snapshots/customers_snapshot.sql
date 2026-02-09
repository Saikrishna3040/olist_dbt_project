{% snapshot customers_snapshot %}

{{
    config(
      target_schema='SNAPSHOTS',
      unique_key='customer_id',
      strategy='check',
      check_cols=['customer_city', 'customer_state', 'customer_zip_code_prefix']
    )
}}

SELECT *
FROM {{ source('olist_raw', 'customers') }}

{% endsnapshot %}