MODEL (
    name champions_league_data.staging.stg_ucl_squads
  , kind FULL
  , cron '0 8 * * 3,4,5'
  , grain id
);

SELECT
          team_id
        , player_id
        , player_name
        , player_position
        , player_nationality
        , player_shirtnumber as player_shirt_number
FROM
  champions_league_data.main.champions_league_team_squad