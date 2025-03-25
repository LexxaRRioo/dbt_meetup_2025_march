{% macro get_json_single_quote() %}

    {%- set result = '{"key": "k1", "val": "v1"}' -%} {{ return(result) }}

{% endmacro %}


{% macro get_json_double_quote() %}

    {%- set result = "{'key': 'k1', 'val': 'v1'}" -%} {{ return(result) }}

{% endmacro %}
