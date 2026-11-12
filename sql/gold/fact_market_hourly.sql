WITH price AS (
  SELECT date_trunc('HOUR', ts_utc) AS hour_utc,
         min(ts_ams) AS hour_ams,
         AVG(price_eur_mwh) AS price_eur_mwh
  FROM workspace.silver.price
  GROUP BY 1
),
load AS (
  SELECT date_trunc('HOUR', ts_utc) AS hour_utc, AVG(mw) AS load_mw
  FROM workspace.silver.power
  WHERE source = 'Load'
  GROUP BY 1
)
SELECT
  p.hour_utc,
  CAST(date_format(p.hour_ams, 'yyyyMMdd') AS INT) AS date_key,
  hour(p.hour_ams) AS hour_key,
  p.price_eur_mwh,
  l.load_mw,
  w.temperature_c,
  w.wind_speed_kmh,
  w.radiation_wm2,
  AVG(p.price_eur_mwh) OVER (ORDER BY p.hour_utc
                             ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS price_7d_avg,
  RANK() OVER (PARTITION BY CAST(date_format(p.hour_ams, 'yyyyMMdd') AS INT)
               ORDER BY p.price_eur_mwh) AS price_rank_in_day
FROM price p
LEFT JOIN load l ON l.hour_utc = p.hour_utc
LEFT JOIN workspace.silver.weather w ON w.ts_utc = p.hour_utc