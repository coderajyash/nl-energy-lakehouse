SELECT
  date_trunc('HOUR', p.ts_utc) AS hour_utc,
  CAST(date_format(min(p.ts_ams), 'yyyyMMdd') AS INT) AS date_key,
  hour(min(p.ts_ams)) AS hour_key,
  p.source,
  AVG(p.mw) AS mw
FROM workspace.silver.power p
JOIN workspace.gold.dim_source s
  ON s.source = p.source AND s.is_generation
GROUP BY date_trunc('HOUR', p.ts_utc), p.source