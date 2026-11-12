-- price_within_bounds.sql
SELECT hour_utc, price_eur_mwh
FROM workspace.gold.fact_market_hourly
WHERE price_eur_mwh < -500 OR price_eur_mwh > 4000