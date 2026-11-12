-- fact_market_no_null_price.sql
SELECT hour_utc FROM workspace.gold.fact_market_hourly WHERE price_eur_mwh IS NULL