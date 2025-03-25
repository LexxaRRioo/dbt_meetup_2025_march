{% if "google-ads" in var("dbt_source_tags") %}

    select
        'custom process logic for GOOGLE ads'

        {% elif "yandex-ads" in var("dbt_source_tags") %}

    select 'custom process logic for YANDEX ads'

{% endif %}
