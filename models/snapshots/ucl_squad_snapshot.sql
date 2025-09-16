MODEL (
  name snapshots.ucl_squad_snapshot,
  kind incremental_by_unique_key(
    unique_key player_id
  ),
  cron '0 12 * * 3#1',
  grain player_id 
);

SELECT
              current_date('America/New_York') as snapshot_date
            , team_id
            , team_name
            , player_id
            , player_name
            , position
            , date_of_birth
            , nationality
FROM
  staging.stg_ucl_squads;