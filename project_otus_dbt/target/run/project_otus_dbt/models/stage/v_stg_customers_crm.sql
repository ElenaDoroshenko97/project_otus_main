
  create view "postgres"."public"."v_stg_customers_crm__dbt_tmp" as (
    








WITH staging AS (
-- Generated by dbtvault.



WITH source_data AS (

    SELECT

    id,
    country,
    age

    FROM "postgres"."public"."source_customers_crm"
),

derived_columns AS (

    SELECT

    id,
    country,
    age,
    id::TEXT AS CUSTOMER_KEY,
    'CSV_CUSTOMERS_CRM'::TEXT AS RECORD_SOURCE

    FROM source_data
),

hashed_columns AS (

    SELECT

    id,
    country,
    age,
    CUSTOMER_KEY,
    RECORD_SOURCE,

    CAST((MD5(NULLIF(UPPER(TRIM(CAST(id AS VARCHAR))), ''))) AS TEXT) AS CUSTOMER_PK,
    CAST(MD5(CONCAT_WS('||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(age AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(country AS VARCHAR))), ''), '^^')
    )) AS TEXT) AS CUSTOMER_HASHDIFF

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    id,
    country,
    age,
    CUSTOMER_KEY,
    RECORD_SOURCE,
    CUSTOMER_PK,
    CUSTOMER_HASHDIFF

    FROM hashed_columns
)

SELECT * FROM columns_to_select
)

SELECT *, 
       current_timestamp AS LOAD_DATE,
       current_timestamp AS EFFECTIVE_FROM
FROM staging
  );