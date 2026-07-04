--
-- Testing the new PROJ version with DGGS
-- see https://git.AddressForAll.org/suporte/issues/86
--

CREATE IF NOT EXISTS EXTENSION PostGIS;

INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES
   -- -- -- --
(  -- IBGE Albers, official urn:ogc:def:crs:EPSG::10857
  10857,
  'BR:IBGE',
  10857,
  '+proj=aea +lat_0=-12 +lon_0=-54 +lat_1=-2 +lat_2=-22 +x_0=5000000 +y_0=10000000 +ellps=WGS84 +units=m +no_defs',
  $$PROJCS[
  "Conica_Equivalente_de_Albers_Brasil",
  GEOGCS[
    "GCS_SIRGAS2000",
    DATUM["D_SIRGAS2000",SPHEROID["Geodetic_Reference_System_of_1980",6378137,298.2572221009113]],
    PRIMEM["Greenwich",0],
    UNIT["Degree",0.017453292519943295]
  ],
  PROJECTION["Albers"],
  PARAMETER["standard_parallel_1",-2],
  PARAMETER["standard_parallel_2",-22],
  PARAMETER["latitude_of_origin",-12],
  PARAMETER["central_meridian",-54],
  PARAMETER["false_easting",5000000],
  PARAMETER["false_northing",10000000],
  UNIT["Meter",1]
 ]$$
),
  -- -- -- --
  --  "DGGS projections" from SRID 955001 to 955099.
  --
( -- rHEALPix default, PROJ v4.8+
  955001,  'DGGS:001:rHEALPix',  1,
  '+proj=rhealpix',
  NULL -- no srtext
),
( -- rHEALPix variant 2, PROJ v4.8+
  955002,  'DGGS:002:rHEALPix',  2,
  '+proj=rhealpix +ellps=WGS84 +south_square=0 +north_square=2',
  NULL -- no srtext
),
( -- rHEALPix main face - Lambert cylindrical equal-area 
  955003,  'DGGS:003:rHEALPix-face01',  2,
  '+proj=cea +ellps=WGS84',
  NULL -- no srtext
),
( -- ISEA default
  955030,  'DGGS:030:ISEA',  30,
  '+proj=isea +ellps=WGS84',
  NULL -- no srtext
)
-- ver projecao principal do rHEALPix, usar ela diretamente 
ON CONFLICT DO NOTHING;

------
CREATE or replace FUNCTION
  round(float,int) RETURNS numeric
  IMMUTABLE PARALLEL SAFE BEGIN ATOMIC;
    SELECT ROUND($1::numeric,$2);
END;

CREATE or replace FUNCTION ST_Segmentize_Cond(
  -- adapted from https://gis.stackexchange.com/a/484773/7505
  g    geometry,     -- the input geometry
  g_diameter float DEFAULT 1  -- meters. 
) RETURNS geometry
  IMMUTABLE PARALLEL SAFE BEGIN ATOMIC;
  SELECT   ST_Segmentize(g, 0.0000025*g_diameter);
 END;

-----

CREATE VIEW issue86_comparing_projs AS
 SELECT ghs, city_name, n_pts,  t6.*
               -- for markdown table report '`'||ghs||'`' as ghs
 FROM generate_series(2,4) t0(i), 
    LATERAL ( VALUES
      (ST_GeoHash( ST_Point(-46.633, -23.550, 4326), i ), 'Sao Paulo' ), 
      (ST_GeoHash( ST_Point(-60.671, 2.8194, 4326), i ), 'Boa Vista' ), 
      (ST_GeoHash( ST_Point(-34.90, -8.050, 4326), i ), 'Recife' ), 
      (ST_GeoHash( ST_Point(-51.23, 30.0331, 4326), i ), 'Porto Alegre' ), 
      (ST_GeoHash( ST_Point(-67.81, -9.9747, 4326), i ), 'Rio Branco' )
    ) t1 (ghs,city_name),
    LATERAL (SELECT ST_SetSRID( ST_GeomFromGeoHash(t1.ghs), 4326) AS geom) t2,
    LATERAL (SELECT ST_Area(t2.geom,true) AS wgs84_area_m2) t3,
    LATERAL (SELECT SQRT(t3.wgs84_area_m2) AS side_m) t4,
    LATERAL (SELECT ST_Segmentize_Cond(t2.geom,side_m) AS geom2) t2b,
    LATERAL (SELECT ST_NPoints(geom2) AS n_pts) t2c,
    LATERAL (SELECT
       ST_Area(ST_Transform(t2b.geom2,10857)) AS albers_m2,
       ST_Area(ST_Transform(t2b.geom2,955030)) AS isea_m2,
       ST_Area(ST_Transform(t2b.geom2,955002)) AS rhpx_m2,
       ST_Area(ST_Transform(t2b.geom2,955003)) AS rhpxFc_m2
    ) t5,
    LATERAL (SELECT
      round( wgs84_area_m2/1000^2, 2) as wgs84_area_km2,
      round( albers_m2/1000^2, 2) as albers_km2,
      round( isea_m2/1000^2, 2) as isea_km2,
      round( rhpx_m2/1000^2, 2) as rhpx_km2,
      round( rhpxFc_m2/1000^2, 2) as rhpxFc_km2,
      -- m2 changes:
      wgs84_area_m2/albers_m2 - 1.0 AS albers_diff,
      wgs84_area_m2/isea_m2 - 1.0    AS isea_diff,
      wgs84_area_m2/rhpx_m2 - 1.0    AS rhpx_diff,
      wgs84_area_m2/rhpxFc_m2 - 1.0    AS rhpxFc_diff
    ) t6
 ORDER BY 1,2
;

CREATE VIEW issue86_report1 AS
 SELECT ghs, city_name,
               wgs84_area_km2, albers_km2, isea_km2, rhpx_km2,
               round(100.0*albers_diff, 2)::text||'%' AS albers_chg,
               round(100.0*isea_diff, 2)::text||'%' AS isea_chg,
               round(100.0*rhpx_diff, 2)::text||'%' AS rhpx_chg,
               round(100.0*rhpxFc_diff, 2)::text||'%' AS rhpxFc_chg
 FROM issue86_comparing_projs
;

CREATE VIEW issue86_report2 AS
  SELECT city_name,
               round(avg(100.0*albers_diff), 2)::text||'%' AS albers_chg,
               round(avg(100.0*isea_diff), 2)::text||'%' AS isea_chg,
               round(avg(100.0*rhpx_diff), 2)::text||'%' AS rhpx_chg,
               round(avg(100.0*rhpxFc_diff), 2)::text||'%' AS rhpxFc_chg
  FROM issue86_comparing_projs
  GROUP BY 1 ORDER BY 1
;

------------

SELECT * FROM issue86_report1;
SELECT * FROM issue86_report2;

