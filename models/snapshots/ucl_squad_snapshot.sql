MODEL (
  name snapshots.ucl_squad_snapshot,
  kind incremental_by_unique_key(
    unique_key player_id
  ),
  cron '0 8 * * 3#1',
  grain player_id 
);

SELECT
              current_date('America/New_York') as snapshot_date
            , team_id
            , player_id
            , player_name
            , player_position
            , player_nationality
            , player_shirt_number
FROM
  staging.stg_ucl_squads;