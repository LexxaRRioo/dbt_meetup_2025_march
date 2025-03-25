-- depends_on: {{ ref('ref_metric_config') }}
-- depends_on: {{ ref('ads') }}
{% if execute -%}
    {% if dbt_unit_testing.running_unit_test() %}
        {% set metrics_config = [
            {
                "metric_code": "ADS.SPEND",
                "source": "source-analytics",
                "source_table": "ads",
                "value_field": "spend",
                "date_field": "date",
                "aggregation_type": "SUM",
            },
            {
                "metric_code": "ADS.CONVERSION.COUNT",
                "source": "source-analytics",
                "source_table": "ads",
                "value_field": "conversions",
                "date_field": "date",
                "aggregation_type": "SUM",
            },
        ] %}
    {% else %}
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
    {% endif %}

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
