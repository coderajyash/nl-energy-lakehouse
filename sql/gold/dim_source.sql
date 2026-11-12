SELECT * FROM VALUES
  ('Wind offshore',   'Wind',    true,  true),
  ('Wind onshore',    'Wind',    true,  true),
  ('Solar',           'Solar',   true,  true),
  ('Biomass',         'Biomass', true,  true),
  ('Fossil gas',      'Gas',     false, true),
  ('Fossil hard coal','Coal',    false, true),
  ('Nuclear',         'Nuclear', false, true),
  ('Waste',           'Other',   false, true),
  ('Others',          'Other',   false, true),
  ('Load',            'Demand',  false, false),
  ('Residual load',   'Demand',  false, false),
  ('Renewable share of load', 'Share', false, false),
  ('Renewable share of generation', 'Share', false, false),
  ('Cross border electricity trading','Trade', false, false)
AS t(source, category, is_renewable, is_generation)