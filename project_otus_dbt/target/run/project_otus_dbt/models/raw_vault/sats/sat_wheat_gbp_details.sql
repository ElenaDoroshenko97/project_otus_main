
      

    insert into "postgres"."public"."sat_wheat_gbp_details" ("date_pk", "date_hashdiff", "tradedate", "price", "open", "high", "low", "volume", "effective_from", "load_date", "record_source")
    (
       select "date_pk", "date_hashdiff", "tradedate", "price", "open", "high", "low", "volume", "effective_from", "load_date", "record_source"
       from "sat_wheat_gbp_details__dbt_tmp010345972097"
    );
  