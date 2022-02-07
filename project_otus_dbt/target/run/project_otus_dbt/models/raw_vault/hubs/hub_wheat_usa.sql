
      

    insert into "postgres"."public"."hub_wheat_usa" ("date_pk", "date_key", "load_date", "record_source")
    (
       select "date_pk", "date_key", "load_date", "record_source"
       from "hub_wheat_usa__dbt_tmp012045976983"
    );
  