{{ config(materialized="table") }}

{{
    dbt_utils.union_relations(
        relations=dbt_utils.get_relations_by_pattern(target.schema, "stg_ads_%"),
        column_override={"spend": "decimal"},
        source_column_name=none,
    )
}}
