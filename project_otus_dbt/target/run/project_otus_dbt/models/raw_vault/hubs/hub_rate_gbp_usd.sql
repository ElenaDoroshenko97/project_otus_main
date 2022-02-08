
      

    insert into "postgres"."public"."hub_rate_gbp_usd" ("date_pk", "date_key", "load_date", "record_source")
    (
       select "date_pk", "date_key", "load_date", "record_source"
       from "hub_rate_gbp_usd__dbt_tmp154405201759"
    );
  