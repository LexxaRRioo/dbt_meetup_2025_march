select *
from
    (
        values
            ('yandex_ads', 'search', '2025-01-01', 980, 95, 28, 1950.60),
            ('yandex_ads', 'banner', '2025-01-02', 1540, 72, 11, 1420.30),
            ('yandex_ads', 'video', '2025-01-03', 760, 48, 9, 980.75),
            ('yandex_ads', 'text', '2025-01-04', 1850, 135, 24, 1880.40),
            ('yandex_ads', 'search', '2025-01-05', 1050, 108, 32, 2150.20),
            ('yandex_ads', 'banner', '2025-01-06', 1680, 78, 13, 1540.80),
            ('yandex_ads', 'video', '2025-01-07', 820, 52, 10, 1050.45),
            ('yandex_ads', 'text', '2025-01-08', 1920, 142, 26, 1950.30),
            ('yandex_ads', 'search', '2025-01-09', 1120, 112, 33, 2250.75),
            ('yandex_ads', 'banner', '2025-01-10', 1750, 81, 15, 1620.90)
    ) as t(source, campaign_type, date, impressions, clicks, conversions, spend)
