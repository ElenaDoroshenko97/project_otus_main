
      

    insert into "postgres"."public"."sat_rate_gbp_usd_details" ("date_pk", "date_hashdiff", "tradedate", "price", "open", "high", "low", "changeperc", "effective_from", "load_date", "record_source")
    (
       select "date_pk", "date_hashdiff", "tradedate", "price", "open", "high", "low", "changeperc", "effective_from", "load_date", "record_source"
       from "sat_rate_gbp_usd_details__dbt_tmp010346147105"
    );
  