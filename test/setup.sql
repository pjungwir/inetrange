BEGIN;

DROP TABLE IF EXISTS geoips;

CREATE TABLE geoips (
  ips inetrange NOT NULL,
  country text NOT NULL,
  CONSTRAINT geoips_dont_overlap
    EXCLUDE USING gist (ips WITH &&)
    DEFERRABLE INITIALLY IMMEDIATE
);

COMMIT;
