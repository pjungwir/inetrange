/* inetrange--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION inetrange" to load this file. \quit


CREATE TYPE inetrange;


CREATE OR REPLACE FUNCTION
inetrange_canonical(r inetrange)
RETURNS inetrange
AS 'inetrange', 'inetrange_canonical'
LANGUAGE c STRICT IMMUTABLE;


CREATE OR REPLACE FUNCTION inet_diff(x inet, y inet)
  RETURNS DOUBLE PRECISION AS
$$
DECLARE
BEGIN 
  RETURN x - y; 
END;
$$
LANGUAGE 'plpgsql' STRICT IMMUTABLE;


CREATE TYPE inetrange AS RANGE (
  subtype = inet,
  subtype_diff = inet_diff,
  canonical = inetrange_canonical
);

