{{ config(materialized="view") }}

{%- set i_list0 = ["a", "b", "c"] %}
{%- set o_list1 = get_list() -%}
{%- set o_list2 = get_list_return() -%}

{{ log(">>>>>>>>>>>>>>>>>> My params: " ~ o_list1 is string, info=true) if execute }}

select 'i_list0', {{ i_list0 }}, {{ i_list0 | length }}, {{ i_list0 is string }}

union all

select 'o_list1', {{ o_list1 }}, {{ o_list1 | length }}, {{ o_list1 is string }}

union all

select 'o_list2', {{ o_list2 }}, {{ o_list2 | length }}, {{ o_list2 is string }}
