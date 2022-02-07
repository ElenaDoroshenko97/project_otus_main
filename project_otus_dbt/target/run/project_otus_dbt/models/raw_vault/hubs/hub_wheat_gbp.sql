
      

    insert into "postgres"."public"."hub_wheat_gbp" ("date_pk", "date_key", "load_date", "record_source")
    (
       select "date_pk", "date_key", "load_date", "record_source"
       from "hub_wheat_gbp__dbt_tmp010345913731"
    );
  