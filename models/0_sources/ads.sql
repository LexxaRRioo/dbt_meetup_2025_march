{{ config(materialized="table") }}

-- depends_on: {{ ref("stg_ads_google") }}
-- depends_on: {{ ref("stg_ads_other") }}
-- depends_on: {{ ref("stg_ads_yandex") }}
{{
    dbt_utils.union_relations(
        relations=dbt_utils.get_relations_by_pattern(target.schema, "stg_ads_%"),
        column_override={"spend": "decimal"},
        source_column_name=none,
    )
}}
