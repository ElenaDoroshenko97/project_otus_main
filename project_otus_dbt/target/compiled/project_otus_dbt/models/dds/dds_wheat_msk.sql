with dds_wheat_msk as(
    select su.tradedate  as tradedate
        ,cast(su.value as decimal(18,2)) as value
        ,cast(su.open as decimal(18,2)) as open
        ,cast(su.close as decimal(18,2)) as close
        ,cast(su.high as decimal(18,2)) as high
        ,cast(su.low as decimal(18,2)) as low
        ,cast(su.volume as decimal(18,2)) as volume
    from "postgres"."public"."hub_wheat_msk" as hu
    left join "postgres"."public"."sat_wheat_msk_details" as su
    on hu.date_pk=su.date_pk
)
select * from dds_wheat_msk