{{
    config(
        enabled=True
    )
}}

{%- set yaml_metadata -%}
source_model: 'source_wheat_usa'
derived_columns:
  DATE_KEY: 'Дата'
  RECORD_SOURCE: '!CSV_WHEAT_USA'
hashed_columns:
  DATE_PK: 'Дата'
  DATE_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'Цена'
      - 'Откр'
      - 'Макс'
      - 'Мин'
      - 'Объём'
      - 'Изм'
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