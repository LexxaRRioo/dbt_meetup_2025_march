{% macro get_list() %}
    {%- set result = ["a", "b", "c"] -%} {{- result -}}
{% endmacro %}

{% macro get_list_return() %}
    {%- set result = ["a", "b", "c"] -%} {{ return(result) }}
{% endmacro %}
