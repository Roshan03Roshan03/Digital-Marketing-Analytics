SELECT
  event_date,
  event_name,
  user_pseudo_id
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 10;

SELECT
  event_date,
  event_name,
  user_pseudo_id
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  event_name = 'purchase'
LIMIT 20;

SELECT
  event_date,
  event_name,
  user_pseudo_id
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  event_name = 'purchase'
ORDER BY
  event_date DESC
LIMIT 20;

SELECT
  event_name,
  COUNT(*) AS total_events
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY
  event_name
ORDER BY
  total_events DESC;

  SELECT
  event_name,
  COUNT(*) AS total_purchases
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  event_name = 'purchase'
GROUP BY
  event_name;

  SELECT
  AVG(ecommerce.purchase_revenue) AS average_revenue
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  event_name = 'purchase';


WITH campaign_data AS (
  SELECT 'Google Ads' AS campaign, 5000 AS clicks, 250 AS conversions
  UNION ALL
  SELECT 'Meta Ads', 3000, 90
  UNION ALL
  SELECT 'YouTube Ads', 2000, 30
  UNION ALL
  SELECT 'Display Ads', 1000, 10
)

SELECT
  campaign,
  clicks,
  conversions,
  ROUND(conversions * 100.0 / clicks, 2) AS conversion_rate,

  CASE
    WHEN conversions * 100.0 / clicks >= 5 THEN 'High Performance'
    WHEN conversions * 100.0 / clicks >= 3 THEN 'Medium Performance'
    ELSE 'Low Performance'
  END AS performance_category

FROM campaign_data
ORDER BY conversion_rate DESC;


WITH campaigns AS (
  SELECT 1 AS campaign_id, 'Google Ads' AS campaign_name
  UNION ALL
  SELECT 2, 'Meta Ads'
  UNION ALL
  SELECT 3, 'YouTube Ads'
),

performance AS (
  SELECT 1 AS campaign_id, 5000 AS clicks, 250 AS conversions
  UNION ALL
  SELECT 2, 3000, 90
  UNION ALL
  SELECT 4, 1000, 20
)

SELECT
  c.campaign_id,
  c.campaign_name,
  p.clicks,
  p.conversions
FROM campaigns c
INNER JOIN performance p
  ON c.campaign_id = p.campaign_id;


WITH campaign_data AS (
  SELECT
    'Google Ads' AS campaign,
    5000 AS clicks,
    250 AS conversions

  UNION ALL

  SELECT
    'Meta Ads',
    3000,
    90

  UNION ALL

  SELECT
    'YouTube Ads',
    2000,
    30
)

SELECT
  campaign,
  clicks,
  conversions,
  ROUND(conversions * 100.0 / clicks, 2) AS conversion_rate
FROM campaign_data
ORDER BY conversion_rate DESC;


SELECT
  campaign,
  clicks,
  conversions
FROM (
  SELECT
    'Google Ads' AS campaign,
    5000 AS clicks,
    250 AS conversions

  UNION ALL

  SELECT
    'Meta Ads',
    3000,
    90

  UNION ALL

  SELECT
    'YouTube Ads',
    2000,
    30
)
WHERE conversions >= 50;

SELECT
  campaign,
  clicks,
  conversions
FROM (
  SELECT
    'Google Ads' AS campaign,
    5000 AS clicks,
    250 AS conversions

  UNION ALL

  SELECT
    'Meta Ads',
    3000,
    90

  UNION ALL

  SELECT
    'YouTube Ads',
    2000,
    30
)
WHERE clicks >= 2800;


WITH campaign_data AS (
  SELECT 'Google Ads' AS campaign, 250 AS conversions
  UNION ALL
  SELECT 'Meta Ads', 90
  UNION ALL
  SELECT 'YouTube Ads', 30
  UNION ALL
  SELECT 'Display Ads', 10
)

SELECT
  campaign,
  conversions,

  ROW_NUMBER() OVER (
    ORDER BY conversions DESC
  ) AS row_number,

  RANK() OVER (
    ORDER BY conversions DESC
  ) AS campaign_rank,

  SUM(conversions) OVER () AS total_conversions

FROM campaign_data;



WITH campaign_data AS (

  SELECT
    'Google Ads' AS platform,
    'Search Campaign' AS campaign,
    100000 AS impressions,
    5000 AS clicks,
    25000 AS ad_spend,
    250 AS conversions,
    75000 AS revenue

  UNION ALL

  SELECT
    'Meta Ads',
    'Brand Awareness',
    80000,
    4000,
    18000,
    160,
    54000

  UNION ALL

  SELECT
    'Google Ads',
    'Display Campaign',
    60000,
    2000,
    12000,
    60,
    24000

  UNION ALL

  SELECT
    'Meta Ads',
    'Lead Generation',
    50000,
    3000,
    15000,
    180,
    45000
)

SELECT
  platform,
  campaign,
  impressions,
  clicks,
  ad_spend,
  conversions,
  revenue,

  ROUND(clicks * 100.0 / impressions, 2) AS CTR,

  ROUND(ad_spend * 1.0 / clicks, 2) AS CPC,

  ROUND(conversions * 100.0 / clicks, 2)
    AS conversion_rate,

  ROUND(revenue * 1.0 / ad_spend, 2) AS ROAS,

  ROUND(ad_spend * 1.0 / conversions, 2) AS CAC

FROM campaign_data
ORDER BY ROAS DESC;


SELECT *
FROM `ga4-obfuscated.Marketing_analysis.campaign_performance`;

