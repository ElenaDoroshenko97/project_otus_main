
  create view "postgres"."dbt"."v_stg_orders__dbt_tmp" as (
    








WITH staging AS (
-- Generated by dbtvault.



WITH source_data AS (

    SELECT

    id,
    user_id,
    order_date,
    status

    FROM "postgres"."dbt"."source_orders"
),

derived_columns AS (

    SELECT

    id,
    user_id,
    order_date,
    status,
    user_id::TEXT AS CUSTOMER_KEY,
    id::TEXT AS ORDER_KEY,
    'CSV_ORDERS'::TEXT AS RECORD_SOURCE

    FROM source_data
),

hashed_columns AS (

    SELECT

    id,
    user_id,
    order_date,
    status,
    CUSTOMER_KEY,
    ORDER_KEY,
    RECORD_SOURCE,

    CAST((MD5(NULLIF(UPPER(TRIM(CAST(user_id AS VARCHAR))), ''))) AS TEXT) AS CUSTOMER_PK,
    CAST((MD5(NULLIF(UPPER(TRIM(CAST(id AS VARCHAR))), ''))) AS TEXT) AS ORDER_PK,
    CAST(MD5(NULLIF(CONCAT_WS('||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(user_id AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(id AS VARCHAR))), ''), '^^')
    ), '^^||^^')) AS TEXT) AS LINK_CUSTOMER_ORDER_PK,
    CAST(MD5(CONCAT_WS('||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(order_date AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(status AS VARCHAR))), ''), '^^')
    )) AS TEXT) AS ORDER_HASHDIFF

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    id,
    user_id,
    order_date,
    status,
    CUSTOMER_KEY,
    ORDER_KEY,
    RECORD_SOURCE,
    CUSTOMER_PK,
    ORDER_PK,
    LINK_CUSTOMER_ORDER_PK,
    ORDER_HASHDIFF

    FROM hashed_columns
)

SELECT * FROM columns_to_select
)

SELECT *, 
       current_timestamp AS LOAD_DATE,
       current_timestamp AS EFFECTIVE_FROM
FROM staging
  );
