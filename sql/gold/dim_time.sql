SELECT
  h AS hour_key,
  format_string('%02d:00', h) AS hour_label,
  CASE WHEN h BETWEEN 7 AND 22 THEN 'Day' ELSE 'Night' END AS day_part
FROM (SELECT explode(sequence(0, 23)) AS h)