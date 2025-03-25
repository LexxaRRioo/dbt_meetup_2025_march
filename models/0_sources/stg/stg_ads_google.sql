select *
from
    (
        values
            ('google_ads', 'search', '2025-01-01', 1420, 145, 42, 3250.75),
            ('google_ads', 'display', '2025-01-02', 2350, 89, 15, 1875.20),
            ('google_ads', 'video', '2025-01-03', 980, 67, 12, 1250.50),
            ('google_ads', 'shopping', '2025-01-04', 3240, 215, 31, 2780.40),
            ('google_ads', 'search', '2025-01-05', 1680, 173, 48, 3650.90),
            ('google_ads', 'display', '2025-01-06', 2100, 92, 17, 1920.30),
            ('google_ads', 'video', '2025-01-07', 1050, 71, 14, 1340.25),
            ('google_ads', 'shopping', '2025-01-08', 3580, 228, 35, 3120.80),
            ('google_ads', 'search', '2025-01-09', 1520, 162, 45, 3480.60),
            ('google_ads', 'display', '2025-01-10', 2280, 85, 16, 1780.45)
    ) as t(source, campaign_type, date, impressions, clicks, conversions, spend)
