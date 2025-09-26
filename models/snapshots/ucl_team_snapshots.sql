MODEL (
  name snapshots.ucl_team_snapshot,
  kind incremental_by_unique_key(
    unique_key team_id
  ),
  cron '0 8 * * 3#1',
  grain team_id 
);

SELECT
              current_date('America/New_York') as snapshot_date
            , area_name
            , team_id
            , team_name
            , team_short_name
            , team_tla
            , team_address
            , team_venue
            , coach_id
            , coach_first_name
            , coach_last_name
            , coach_name
            , coach_nationality
            , coach_contract_start
            , coach_contract_until
            , lastupdated
            , latitude
            , longitude
            , european_rank
            , ucl_rank
FROM
  intermediate.int_ucl_teams;