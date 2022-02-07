
select * ,
    TRADEDATE as DATE_KEY,
    '!STG_WHEAT_MSK' as RECORD_SOURCE,
    {{ var('load_date') }} AS LOAD_DATE,
    {{ var('load_date') }} AS EFFECTIVE_FROM
from {{ source('src','stg_wheat_msk') }}

