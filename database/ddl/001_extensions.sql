-- 1. Instalar la extensión para quitar acentos
CREATE EXTENSION IF NOT EXISTS unaccent;

-- 2. Instalar la extensión para búsquedas difusas y typos
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- 3. Instalar PostGIS para análisis geográfico
CREATE EXTENSION IF NOT EXISTS postgis;