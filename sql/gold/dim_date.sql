SELECT
  CAST(date_format(d, 'yyyyMMdd') AS INT) AS date_key,
  d AS date,
  year(d) AS year,
  month(d) AS month,
  date_format(d, 'MMM') AS month_name,
  date_format(d, 'yyyy-MM') AS year_month,
  dayofweek(d) AS day_of_week,
  date_format(d, 'E') AS day_name,
  dayofweek(d) IN (1, 7) AS is_weekend
FROM (SELECT explode(sequence(DATE'2025-01-01', date_add(current_date(), 2), INTERVAL 1 DAY)) AS d)