MODEL (
    name champions_league_data.intermediate.int_ucl_teams
  , kind FULL
  , cron '0 12 * * 4'
  , grain team_id
);

SELECT
          t.area_name
        , t.team_id
        , t.team_name
        , t.team_short_name
        , t.team_tla
        , t.team_address
        , t.team_venue
        , t.coach_id
        , t.coach_first_name
        , t.coach_last_name
        , t.coach_name
        , t.coach_nationality
        , t.coach_contract_start
        , t.coach_contract_until
        , t.lastupdated
        , COALESCE(t.latitude, l.latitude) as latitude
        , COALESCE(t.longitude, l.longitude) as longitude 
        , r.rank 
FROM staging.stg_ucl_teams t 
JOIN main.ucl_teams_city_latlong l 
ON t.team_id = l.team_id 
JOIN main.ucl_european_rankings r 
ON t.team_id = r.team_id