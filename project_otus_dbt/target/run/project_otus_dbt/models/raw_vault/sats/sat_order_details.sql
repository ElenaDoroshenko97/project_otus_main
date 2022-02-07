
      

    insert into "postgres"."public"."sat_order_details" ("order_pk", "order_hashdiff", "order_date", "status", "effective_from", "load_date", "record_source")
    (
       select "order_pk", "order_hashdiff", "order_date", "status", "effective_from", "load_date", "record_source"
       from "sat_order_details__dbt_tmp175221450151"
    );
  