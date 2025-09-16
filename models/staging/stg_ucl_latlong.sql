MODEL (
    name champions_league_data.staging.stg_ucl_latlong
  , kind FULL
  , cron '0 12 * * 4'
  , grain team_id
);

SELECT
    Team_ID
    -- Latitude: negative if 'S'
    , (CASE
        WHEN LOWER(TRIM(Latitude)) LIKE '%s%' THEN -1
        ELSE 1
     END) *
     CAST(
         REGEXP_REPLACE(
             TRIM(Latitude),        -- remove outside spaces
             '[^0-9.+-]',           -- keep only digits, +, -, .
             '',
             'g'
         ) AS DOUBLE
     ) AS latitude,

    -- Longitude: negative if 'W'
    ,(CASE
        WHEN LOWER(TRIM(Longitude)) LIKE '%w%' THEN -1
        ELSE 1
     END) *
     CAST(
         REGEXP_REPLACE(
             TRIM(Longitude),
             '[^0-9.+-]',
             '',
             'g'
         ) AS DOUBLE
     ) AS longitude
FROM main.ucl_teams_city_latlong