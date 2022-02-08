with gbp as(
    select cast(to_date(su.tradedate, 'DD.MM.YYYY') as date) as tradedate
        ,hu.date_pk
        ,cast(su.price as decimal(18,2))/100.0*rt.rate as price
        ,cast(su.open as decimal(18,2))/100.0 as open
        ,cast(su.high as decimal(18,2))/100.0 as high
        ,cast(su.low as decimal(18,2))/100.0 as low
        ,cast(su.volume as varchar(50)) as volume
    from {{ ref ('hub_wheat_gbp') }} as hu
    left join {{ ref ('sat_wheat_gbp_details') }} as su
    on hu.date_pk=su.date_pk
    left join {{ ref ('dds_rate_gbp_usd') }} as rt
    on hu.date_pk=rt.date_pk
)
select * from gbp

