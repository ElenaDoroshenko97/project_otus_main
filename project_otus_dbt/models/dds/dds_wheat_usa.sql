with usa as (
    select cast(to_date(su.tradedate, 'DD.MM.YYYY') as date) as tradedate
        ,hu.date_pk
        ,cast(su.price as decimal(18,2))/100.0/2.7 as price
        ,cast(su.open as decimal(18,2))/100.0 as open
        ,cast(su.high as decimal(18,2))/100.0 as high
        ,cast(su.low as decimal(18,2))/100.0 as low
        ,cast(su.volume as varchar(50)) as volume
    from {{ ref ('hub_wheat_usa') }} as hu
    left join {{ ref ('sat_wheat_usa_details') }} as su
    on hu.date_pk=su.date_pk
)
select * from usa


