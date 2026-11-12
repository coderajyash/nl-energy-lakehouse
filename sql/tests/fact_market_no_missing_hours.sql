-- fact_market_no_missing_hours.sql
WITH bounds AS (
  SELECT MIN(hour_utc) AS lo, MAX(hour_utc) AS hi FROM workspace.gold.fact_market_hourly
),
expected AS (
  SELECT explode(sequence(lo, hi, INTERVAL 1 HOUR)) AS hour_utc FROM bounds
)
SELECT e.hour_utc
FROM expected e
LEFT ANTI JOIN workspace.gold.fact_market_hourly f ON f.hour_utc = e.hour_utc