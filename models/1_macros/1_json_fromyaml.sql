{{ config(materialized="view") }}

{%- set o_yaml_sin_q = fromyaml(get_json_single_quote()) -%}
{%- set o_yaml_dou_q = fromyaml(get_json_double_quote()) %}

select
    'o_yaml_sin_q',
    -- '{{ o_yaml_sin_q }}',
    '{{ o_yaml_sin_q["val"] }}',
    '{{ o_yaml_sin_q is mapping }}'

union all

select
    ' o_yaml_dou_q ',
    -- '{{ o_yaml_dou_q }}',
    '{{ o_yaml_dou_q["val"] }}',
    '{{ o_yaml_dou_q is mapping }}'
