
  create view "postgres"."public"."v_stg_wheat_msk__dbt_tmp" as (
    select * ,
    TRADEDATE as DATE_KEY,
    '!STG_WHEAT_MSK' as RECORD_SOURCE,
    current_timestamp AS LOAD_DATE,
    current_timestamp AS EFFECTIVE_FROM
from "postgres"."public"."stg_wheat_msk"
  );
