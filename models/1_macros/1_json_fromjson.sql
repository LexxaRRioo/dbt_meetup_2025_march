{{ config(materialized="view") }}

{%- set o_json_sin_q = fromjson(get_json_single_quote()) -%}
{%- set o_json_dou_q = fromjson(get_json_double_quote()) -%}

select
    'o_json_sin_q',
    -- '{{ o_json_sin_q }}',
    '{{ o_json_sin_q["val"] }}',
    '{{ o_json_sin_q is mapping }}'

union all

select
    'o_json_dou_q',
    -- '{{ o_json_dou_q }}',
    '{{ o_json_dou_q["val"] }}',
    '{{ o_json_dou_q is mapping }}'
