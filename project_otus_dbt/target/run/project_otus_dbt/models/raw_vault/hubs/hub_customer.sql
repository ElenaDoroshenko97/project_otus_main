
      

    insert into "postgres"."public"."hub_customer" ("customer_pk", "customer_key", "load_date", "record_source")
    (
       select "customer_pk", "customer_key", "load_date", "record_source"
       from "hub_customer__dbt_tmp175221689241"
    );
  