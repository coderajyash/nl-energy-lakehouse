-- fact_market_no_duplicates.sql
SELECT hour_utc, COUNT(*) AS n
FROM workspace.gold.fact_market_hourly
GROUP BY hour_utc
HAVING COUNT(*) > 1