with rate as(
    select to_date(su.tradedate, 'DD.MM.YYYY') as tradedate
        ,hu.date_pk
        ,cast(su.price as decimal(18,2))/10000.0 as rate
        ,cast(su.open as decimal(18,2))/10000.0 as open
        ,cast(su.high as decimal(18,2))/10000.0 as high
        ,cast(su.low as decimal(18,2))/10000.0 as low
    from {{ ref ('hub_rate_gbp_usd') }} as hu
    left join {{ ref ('sat_rate_gbp_usd_details') }} as su
    on hu.date_pk=su.date_pk
)
select * from rate

