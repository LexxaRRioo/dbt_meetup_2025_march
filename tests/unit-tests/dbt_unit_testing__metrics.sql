-- depends_on: {{ ref('ref_metric_config') }}
{% call dbt_unit_testing.test(
    "1_metrics",
    """Test ad metrics calculation logic for different metric types:
    * sum total ad spend per day
    * sum conversions per day
    """
) %}

    {% call dbt_unit_testing.mock_ref("ads") %}
        source|campaign_type|date|impressions|clicks|conversions|spend
        'google_ads'|'search' |'2025-01-01'|1420|145|42|3250.75
        'google_ads'|'display'|'2025-01-01'|2350|89 |15|1875.20
        'other_ads' |'social' |'2025-01-01'|3250|285|52|2850.40
        'google_ads'|'search' |'2025-01-02'|1680|173|48|3650.90
        'other_ads' |'email'  |'2025-01-02'|1280|96 |18|1350.60
    {% endcall %}

    {% call dbt_unit_testing.expect() %}
        metric_code           |metric_value::double|metric_date
        'ADS.SPEND'           |7976.35             |'2025-01-01'
        'ADS.SPEND'           |5001.50             |'2025-01-02'
        'ADS.CONVERSION.COUNT'|109                 |'2025-01-01'
        'ADS.CONVERSION.COUNT'|66                  |'2025-01-02'
    {% endcall %}

{% endcall %}
