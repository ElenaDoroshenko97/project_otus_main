








WITH staging AS (
-- Generated by dbtvault.



WITH source_data AS (

    SELECT

    Дата,
    Цена,
    Откр,
    Макс,
    Мин,
    Объём,
    Изм

    FROM "postgres"."public"."source_wheat_usa"
),

derived_columns AS (

    SELECT

    Дата,
    Цена,
    Откр,
    Макс,
    Мин,
    Объём,
    Изм,
    Дата::TEXT AS DATE_KEY,
    'CSV_WHEAT_USA'::TEXT AS RECORD_SOURCE

    FROM source_data
),

hashed_columns AS (

    SELECT

    Дата,
    Цена,
    Откр,
    Макс,
    Мин,
    Объём,
    Изм,
    DATE_KEY,
    RECORD_SOURCE,

    CAST((MD5(NULLIF(UPPER(TRIM(CAST(Дата AS VARCHAR))), ''))) AS TEXT) AS DATE_PK,
    CAST(MD5(CONCAT_WS('||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(Изм AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(Макс AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(Мин AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(Объём AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(Откр AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(Цена AS VARCHAR))), ''), '^^')
    )) AS TEXT) AS DATE_HASHDIFF

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    Дата,
    Цена,
    Откр,
    Макс,
    Мин,
    Объём,
    Изм,
    DATE_KEY,
    RECORD_SOURCE,
    DATE_PK,
    DATE_HASHDIFF

    FROM hashed_columns
)

SELECT * FROM columns_to_select
)

SELECT *, 
       current_timestamp AS LOAD_DATE,
       current_timestamp AS EFFECTIVE_FROM
FROM staging