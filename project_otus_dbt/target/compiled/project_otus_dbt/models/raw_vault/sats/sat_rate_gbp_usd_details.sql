-- Generated by dbtvault.

WITH source_data AS (
    SELECT a.DATE_PK, a.DATE_HASHDIFF, a.TRADEDATE, a.PRICE, a.OPEN, a.HIGH, a.LOW, a.CHANGEPERC, a.EFFECTIVE_FROM, a.LOAD_DATE, a.RECORD_SOURCE
    FROM "postgres"."public"."v_stg_rate_gbp_usd" AS a
),

update_records AS (
    SELECT a.DATE_PK, a.DATE_HASHDIFF, a.TRADEDATE, a.PRICE, a.OPEN, a.HIGH, a.LOW, a.CHANGEPERC, a.EFFECTIVE_FROM, a.LOAD_DATE, a.RECORD_SOURCE
    FROM "postgres"."public"."sat_rate_gbp_usd_details" as a
    JOIN source_data as b
    ON a.DATE_PK = b.DATE_PK
),

latest_records AS (

SELECT * FROM (    
    SELECT c.DATE_PK, c.DATE_HASHDIFF, c.LOAD_DATE,
           CASE WHEN RANK()
           OVER (PARTITION BY c.DATE_PK
           ORDER BY c.LOAD_DATE DESC) = 1
    THEN 'Y' ELSE 'N' END AS latest
    FROM update_records as c
) as s
WHERE latest = 'Y'

),

records_to_insert AS (
    SELECT DISTINCT e.DATE_PK, e.DATE_HASHDIFF, e.TRADEDATE, e.PRICE, e.OPEN, e.HIGH, e.LOW, e.CHANGEPERC, e.EFFECTIVE_FROM, e.LOAD_DATE, e.RECORD_SOURCE
    FROM source_data AS e
    LEFT JOIN latest_records
    ON latest_records.DATE_HASHDIFF = e.DATE_HASHDIFF
    WHERE latest_records.DATE_HASHDIFF IS NULL
)

SELECT * FROM records_to_insert