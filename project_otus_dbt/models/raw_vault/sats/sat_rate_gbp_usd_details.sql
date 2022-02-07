{{
    config(
        enabled=True
    )
}}

{%- set source_model = "v_stg_rate_gbp_usd" -%}
{%- set src_pk = "DATE_PK" -%}
{%- set src_hashdiff = "DATE_HASHDIFF" -%}
{%- set src_payload = ["TRADEDATE", "PRICE", "OPEN", "HIGH", "LOW", "CHANGEPERC"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                src_payload=src_payload, src_eff=src_eff,
                src_ldts=src_ldts, src_source=src_source,
                source_model=source_model) }}
