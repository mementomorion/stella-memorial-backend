CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS pamyatniki (
  id text PRIMARY KEY,
  name text NOT NULL,
  type text,
  price numeric NOT NULL,
  original_price numeric,
  images jsonb DEFAULT '[]'::jsonb,
  availability text NOT NULL,
  category text NOT NULL,
  material text,
  color text,
  polishing text,
  description text,
  production_time text,
  installation_warranty text,
  product_warranty text,
  dimensions jsonb DEFAULT '{}'::jsonb,
  features jsonb DEFAULT '[]'::jsonb,
  specifications jsonb DEFAULT '{}'::jsonb,
  is_new boolean DEFAULT false,
  is_exclusive boolean DEFAULT false,
  material_variants jsonb DEFAULT '[]'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS oformlenie (
  id text PRIMARY KEY,
  name text NOT NULL,
  type text,
  price numeric NOT NULL,
  original_price numeric,
  images jsonb DEFAULT '[]'::jsonb,
  availability text NOT NULL,
  category text NOT NULL,
  material text,
  color text,
  polishing text,
  description text,
  production_time text,
  installation_warranty text,
  product_warranty text,
  dimensions jsonb DEFAULT '{}'::jsonb,
  features jsonb DEFAULT '[]'::jsonb,
  specifications jsonb DEFAULT '{}'::jsonb,
  is_new boolean DEFAULT false,
  is_exclusive boolean DEFAULT false,
  material_variants jsonb DEFAULT '[]'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS blagoustroystvo (
  id text PRIMARY KEY,
  name text NOT NULL,
  type text,
  price numeric NOT NULL,
  original_price numeric,
  images jsonb DEFAULT '[]'::jsonb,
  availability text NOT NULL,
  category text NOT NULL,
  material text,
  color text,
  polishing text,
  description text,
  production_time text,
  installation_warranty text,
  product_warranty text,
  dimensions jsonb DEFAULT '{}'::jsonb,
  features jsonb DEFAULT '[]'::jsonb,
  specifications jsonb DEFAULT '{}'::jsonb,
  is_new boolean DEFAULT false,
  is_exclusive boolean DEFAULT false,
  material_variants jsonb DEFAULT '[]'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS kompleksy (
  id text PRIMARY KEY,
  name text NOT NULL,
  type text,
  price numeric NOT NULL,
  original_price numeric,
  images jsonb DEFAULT '[]'::jsonb,
  availability text NOT NULL,
  category text NOT NULL,
  material text,
  color text,
  polishing text,
  description text,
  production_time text,
  installation_warranty text,
  product_warranty text,
  dimensions jsonb DEFAULT '{}'::jsonb,
  features jsonb DEFAULT '[]'::jsonb,
  specifications jsonb DEFAULT '{}'::jsonb,
  is_new boolean DEFAULT false,
  is_exclusive boolean DEFAULT false,
  material_variants jsonb DEFAULT '[]'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_timestamp_pamyatniki
BEFORE UPDATE ON pamyatniki
FOR EACH ROW EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp_oformlenie
BEFORE UPDATE ON oformlenie
FOR EACH ROW EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp_blagoustroystvo
BEFORE UPDATE ON blagoustroystvo
FOR EACH ROW EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp_kompleksy
BEFORE UPDATE ON kompleksy
FOR EACH ROW EXECUTE PROCEDURE trigger_set_timestamp();
