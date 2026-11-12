CREATE TABLE IF NOT EXISTS workspace.silver.price (
  ts_utc TIMESTAMP, ts_ams TIMESTAMP, price_eur_mwh DOUBLE, _updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS workspace.silver.power (
  ts_utc TIMESTAMP, ts_ams TIMESTAMP, source STRING, mw DOUBLE, _updated_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS workspace.silver.weather (
  ts_utc TIMESTAMP, temperature_c DOUBLE, wind_speed_kmh DOUBLE, radiation_wm2 DOUBLE,
  _updated_at TIMESTAMP
);