
      

    insert into "postgres"."public"."hub_wheat_msk" ("date_pk", "date_key", "load_date", "record_source")
    (
       select "date_pk", "date_key", "load_date", "record_source"
       from "hub_wheat_msk__dbt_tmp010346621733"
    );
  