

  create  table "postgres"."public"."dim_day__dbt_tmp"
  as (
    with dim_day as (
    select date::date,
        extract('isodow' from date) as dow,
        to_char(date, 'dy') as day,
        date_trunc('week' , date) as first_day_week,
        extract('week' from date) as week_id,
        extract('year' from date)*100+extract('week' from date) as yearweek_id,

        to_char(date, 'MON') as month,
        concat(to_char(date, 'MM'), to_char(date, 'MON')) as mm_month,
        extract('month' from date) as moth_id,
        extract('year' from date)*100+extract('month' from date) as yearmonth_id,
        extract('year' from date) as year,
        extract('day' from (date + interval '2 month - 1 day')) = 29 as leap
    from generate_series(date '2012-01-01',
                         date '2025-12-31',
                         interval '1 day')
             as t(date)
)

select * from dim_day
order by date desc
  );