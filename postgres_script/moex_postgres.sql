/*
таблица tmp_wheat_msk создается и дропается в python
  create table tmp_wheat_msk
(
    "BOARDID"        text,
    "SECID"          text,
    "TRADEDATE"      text,
    "SHORTNAME"      text,
    "NAME"           text,
    "CLOSE"          double precision,
    "OPEN"           double precision,
    "HIGH"           double precision,
    "LOW"            double precision,
    "VALUE"          double precision,
    "DURATION"       bigint,
    "YIELD"          bigint,
    "DECIMALS"       bigint,
    "CAPITALIZATION" bigint,
    "CURRENCYID"     text,
    "DIVISOR"        double precision,
    "TRADINGSESSION" text,
    "VOLUME"         double precision
);

alter table tmp_wheat_msk
    owner to postgres;
*/


drop table stg_wheat_msk;
create table public.stg_wheat_msk
(
    TRADEDATE      timestamp(0),
    NAME           varchar(512),
    CLOSE          decimal(18,0),
    OPEN           decimal(18,0),
    HIGH           decimal(18,0),
    LOW            decimal(18,0),
    VALUE          decimal(18,0),
    VOLUME         decimal(18,0),
    PROCESSED_DTTM timestamp(0)
);

alter table stg_wheat_msk
    owner to postgres;

--Запросы при заливке данных в python
delete from public.stg_wheat_msk where TRADEDATE between --'2021-12-02' and '2022-02-07';

insert into public.stg_wheat_msk (TRADEDATE ,NAME ,CLOSE ,OPEN ,HIGH ,LOW ,VALUE ,VOLUME ,PROCESSED_DTTM)
select
      cast("TRADEDATE"  as date) as TRADEDATE
     ,cast("NAME"       as varchar(512)) as NAME
     ,cast("CLOSE"      as decimal(18,0)) as CLOSE
     ,cast("OPEN"       as decimal(18,0)) as OPEN
     ,cast("HIGH"       as decimal(18,0)) as HIGH
     ,cast("LOW"        as decimal(18,0)) as LOW
     ,cast("VALUE"      as decimal(18,0)) as VALUE
     ,cast("VOLUME"     as decimal(18,0)) as VOLUME
     ,current_timestamp::timestamp as PROCESSED_DTTM
FROM public.tmp_wheat_msk as t;


--проверки:
select * from public.tmp_wheat_msk;
select count(distinct tradedate) from public.stg_wheat_msk; --215
select min(tradedate), max(tradedate) from public.stg_wheat_msk;
select * from public.stg_wheat_msk where tradedate between '2021-12-02' and '2022-02-07';       --82
delete from public.stg_wheat_msk where TRADEDATE between '2021-12-02' and '2022-02-07';

--truncate table public.integro_wheat_msk;
--truncate table public.tmp_wheat_msk;

SELECT * FROM integro_wheat_msk;
SELECT * FROM stg_wheat_msk;

