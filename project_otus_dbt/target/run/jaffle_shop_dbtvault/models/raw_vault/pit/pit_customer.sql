
      

    insert into "postgres"."dbt"."pit_customer" ("customer_pk", "first_name", "last_name", "email", "effective_from", "effective_to")
    (
       select "customer_pk", "first_name", "last_name", "email", "effective_from", "effective_to"
       from "pit_customer__dbt_tmp191626690188"
    );
  