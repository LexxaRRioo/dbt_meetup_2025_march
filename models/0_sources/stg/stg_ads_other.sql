select *
from
    (
        values
            ('other_ads', 'social', '2025-01-01', 3250, 285, 52, 2850.40),
            ('other_ads', 'email', '2025-01-02', 1280, 96, 18, 1350.60),
            ('other_ads', 'partner', '2025-01-03', 860, 42, 8, 980.25),
            ('other_ads', 'referral', '2025-01-04', 740, 35, 7, 850.80),
            ('other_ads', 'social', '2025-01-05', 3480, 312, 58, 3120.70),
            ('other_ads', 'email', '2025-01-06', 1380, 103, 21, 1480.30),
            ('other_ads', 'partner', '2025-01-07', 920, 48, 10, 1050.45),
            ('other_ads', 'referral', '2025-01-08', 820, 41, 9, 920.60),
            ('other_ads', 'social', '2025-01-09', 3650, 325, 62, 3350.90),
            ('other_ads', 'email', '2025-01-10', 1420, 110, 23, 1580.75)
    ) as t(source, campaign_type, date, impressions, clicks, conversions, spend)
