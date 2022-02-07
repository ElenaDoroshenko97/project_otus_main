
      

    insert into "postgres"."dbt"."sat_customer_crm_details" ("customer_pk", "customer_hashdiff", "country", "age", "effective_from", "load_date", "record_source")
    (
       select "customer_pk", "customer_hashdiff", "country", "age", "effective_from", "load_date", "record_source"
       from "sat_customer_crm_details__dbt_tmp142939175387"
    );
  