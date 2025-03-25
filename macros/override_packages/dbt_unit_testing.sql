{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%} {{ default_schema }}
    {%- else -%} {{ custom_schema_name | trim }}
    {%- endif -%}

{%- endmacro %}

{% macro ref() %} {{ return(dbt_unit_testing.ref(*varargs, **kwargs)) }} {% endmacro %}

{% macro source() %}
    {{ return(dbt_unit_testing.source(*varargs, **kwargs)) }}
{% endmacro %}

{% macro is_incremental() %}
    {{ return(dbt_unit_testing.is_incremental()) }}
{% endmacro %}
