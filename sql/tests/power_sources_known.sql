-- power_sources_known.sql
SELECT DISTINCT p.source
FROM workspace.silver.power p
LEFT ANTI JOIN workspace.gold.dim_source s ON s.source = p.source