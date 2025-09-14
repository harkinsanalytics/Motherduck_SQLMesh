MODEL (
    name champions_league_data.staging.stg_ucl_squads
  , kind FULL
  , cron '@weekly'
  , grain id
);

SELECT
          team_id
        , team_name
        , id as player_id
        , name as player_name
        , position
        , dateOfBirth as date_of_birth
        , nationality
FROM
  champions_league_data.main.champions_league_team_squad