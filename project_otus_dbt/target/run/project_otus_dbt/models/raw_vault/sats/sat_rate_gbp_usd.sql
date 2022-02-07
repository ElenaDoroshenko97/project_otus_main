
      

    insert into "postgres"."public"."sat_rate_gbp_usd" ("date_pk", "date_hashdiff", "tradedate", "price", "open", "high", "low", "changeperc", "effective_from", "load_date", "record_source")
    (
       select "date_pk", "date_hashdiff", "tradedate", "price", "open", "high", "low", "changeperc", "effective_from", "load_date", "record_source"
       from "sat_rate_gbp_usd__dbt_tmp002828470894"
    );
  