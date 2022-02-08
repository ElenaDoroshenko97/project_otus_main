
      

    insert into "postgres"."public"."sat_wheat_msk_details" ("date_pk", "date_hashdiff", "tradedate", "value", "open", "close", "high", "low", "volume", "effective_from", "load_date", "record_source")
    (
       select "date_pk", "date_hashdiff", "tradedate", "value", "open", "close", "high", "low", "volume", "effective_from", "load_date", "record_source"
       from "sat_wheat_msk_details__dbt_tmp154405954014"
    );
  