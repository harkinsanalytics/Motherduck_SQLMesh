MODEL (
    name champions_league_data.staging.stg_ucl_teams
  , kind FULL
  , cron '0 8 * * 3,4,5'
  , grain id
);

SELECT
          team_id
        , team_name
        , team_shortName as team_short_name 
        , team_tla
        , address as team_address 
        , venue as team_venue 
        , lastUpdated
        , area_id
        , area_name
        , coach_id
        , coach_firstName as coach_first_name 
        , coach_lastName as coach_last_name 
        , coach_name
        , coach_nationality
        , coach_contract_start
        , coach_contract_until
        , last_modified
FROM
  champions_league_data.main.champions_league_teams
