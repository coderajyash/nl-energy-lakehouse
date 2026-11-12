-- fact_generation_no_duplicates.sql
SELECT hour_utc, source, COUNT(*) AS n
FROM workspace.gold.fact_generation_hourly
GROUP BY hour_utc, source
HAVING COUNT(*) > 1