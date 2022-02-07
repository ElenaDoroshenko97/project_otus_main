-- Generated by dbtvault.

WITH row_rank_1 AS (

SELECT * FROM (
    SELECT DATE_PK, DATE_KEY, LOAD_DATE, RECORD_SOURCE,
           ROW_NUMBER() OVER(
               PARTITION BY DATE_PK
               ORDER BY LOAD_DATE ASC
           ) AS row_number
    FROM "postgres"."public"."v_stg_rate_gbp_usd"

) as h
WHERE row_number = 1
),

records_to_insert AS (
    SELECT a.DATE_PK, a.DATE_KEY, a.LOAD_DATE, a.RECORD_SOURCE
    FROM row_rank_1 AS a
    LEFT JOIN "postgres"."public"."hub_rate_gbp_usd" AS d
    ON a.DATE_PK = d.DATE_PK
    WHERE d.DATE_PK IS NULL
)

SELECT * FROM records_to_insert