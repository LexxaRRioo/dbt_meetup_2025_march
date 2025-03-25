-- depends_on: {{ ref('ref_metric_config') }}
-- depends_on: {{ ref('ads') }}
{%- if execute -%}

    {%- set metrics_config_query -%}
        select 
            metric_code,
            source,
            source_table,
            value_field,
            date_field,
            aggregation_type
        from {{ ref('ref_metric_config') }}
    {%- endset -%}
    {%- set metrics_config = run_query(metrics_config_query) %}

    with
        source_data as (
            {% for metric in metrics_config %}
                select
                    '{{ metric.metric_code }}' as metric_code,
                    {{ metric.aggregation_type }} (
                        cast({{ metric.value_field }} as decimal)
                    ) as metric_value,
                    cast({{ metric.date_field }} as date) as metric_date
                from {{ ref(metric.source_table) }}
                group by cast({{ metric.date_field }} as date)

                {% if not loop.last %}
                    union all
                {% endif %}
            {% endfor %}
        )

    select metric_code, metric_value, metric_date
    from source_data

{% endif %}
