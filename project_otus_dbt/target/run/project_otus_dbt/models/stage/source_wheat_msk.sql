
  create view "postgres"."public"."source_wheat_msk__dbt_tmp" as (
    with source_wheat_msk as (
select * from public.stg_wheat_msk
)

select * from source_wheat_msk
  );
