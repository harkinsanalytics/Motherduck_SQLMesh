MODEL (
    name champions_league_data.staging.stg_ucl_teams
  , kind FULL
  , cron '0 12 * * 4'
  , grain id
);

SELECT
          area_name
        , id as team_id 
        , name as team_name 
        , shortName as team_short_name
        , tla as team_tla 
        , address as team_address
        , venue as team_venue
        , coach_id
        , coach_firstName as coach_first_name 
        , coach_lastName as coach_last_name 
        , coach_name 
        , coach_nationality
        , coach_contract_start
        , coach_contract_until
        , lastUpdated
        , latitude
        , longitude
FROM
  champions_league_data.main.champions_league_teams