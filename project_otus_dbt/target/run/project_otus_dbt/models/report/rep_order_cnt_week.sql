

  create  table "postgres"."public"."rep_order_cnt_week__dbt_tmp"
  as (
    with rep_order_cnt_week as (

    select 
        date_trunc('week', sod.order_date) as order_week
        ,sod.status
        ,md5(cast(concat(coalesce(cast(date_trunc('week', sod.order_date) as 
    varchar
), ''), '-', coalesce(cast(status as 
    varchar
), '')) as 
    varchar
)) as id
        ,count(sod.order_pk) as cnt_order
    from "postgres"."public"."hub_order" as ho
    left join "postgres"."public"."sat_order_details" as sod 
    on ho.order_pk=sod.order_pk
    -- inner join "postgres"."public"."dim_day" as d 
    -- on ord.order_date=d.date 
    group by sod.status
        ,date_trunc('week', sod.order_date)
)

select * from rep_order_cnt_week
  );