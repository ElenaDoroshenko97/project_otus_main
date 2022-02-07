{{
    config(
        enabled=True
    )
}}

{%- set yaml_metadata -%}
source_model: 'source_wheat_gbp'

derived_columns:
  DATE_KEY: 'TRADEDATE'
  RECORD_SOURCE: '!CSV_WHEAT_GBP'
hashed_columns:
  DATE_PK: 'TRADEDATE'
  DATE_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'PRICE'
      - 'OPEN'
      - 'HIGH'
      - 'LOW'
      - 'VOLUME'
      - 'CHANGEPERC'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}


WITH staging AS (
{{ dbtvault.stage(include_source_columns=true,
                  source_model=source_model,
                  derived_columns=derived_columns,
                  hashed_columns=hashed_columns,
                  ranked_columns=none) }}
)

SELECT *, 
       {{ var('load_date') }} AS LOAD_DATE,
       {{ var('load_date') }} AS EFFECTIVE_FROM
FROM staging