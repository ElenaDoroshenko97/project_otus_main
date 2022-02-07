-- Generated by dbtvault.

WITH row_rank_1 AS (
   
SELECT * FROM (
    SELECT LINK_CUSTOMER_ORDER_PK, CUSTOMER_PK, ORDER_PK, LOAD_DATE, RECORD_SOURCE,
           ROW_NUMBER() OVER(
               PARTITION BY LINK_CUSTOMER_ORDER_PK
               ORDER BY LOAD_DATE ASC
           ) AS row_number
    FROM "postgres"."public"."v_stg_orders"

) as l
WHERE row_number = 1
),

records_to_insert AS (
    SELECT a.LINK_CUSTOMER_ORDER_PK, a.CUSTOMER_PK, a.ORDER_PK, a.LOAD_DATE, a.RECORD_SOURCE
    FROM row_rank_1 AS a
    LEFT JOIN "postgres"."public"."link_customer_order" AS d
    ON a.LINK_CUSTOMER_ORDER_PK = d.LINK_CUSTOMER_ORDER_PK
    WHERE d.LINK_CUSTOMER_ORDER_PK IS NULL
)

SELECT * FROM records_to_insert