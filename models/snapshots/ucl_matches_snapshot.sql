MODEL (
  name snapshots.ucl_matches_snapshot,
  kind incremental_by_unique_key(
    unique_key (match_id)
  ),
  cron '0 8 * * 3,4,5', -- Schedule this to run once a day
  start '2025-09-15'
);

-- Select all games that have already been played.
SELECT
          competition_id
        , competition_name
        , competition_code
        , season_id
        , season_start_date
        , season_end_date
        , season_current_matchday
        , match_id
        , match_datetime_est
        , match_status
        , matchday
        , stage
        , group
        , lastupdated
        , hometeam_id
        , hometeam_name
        , hometeam_shortname
        , hometeam_tla
        , awayteam_id
        , awayteam_name
        , awayteam_shortname
        , awayteam_tla
        , score_winner
        , score_duration
        , score_fulltime_home
        , score_fulltime_away
        , score_halftime_home
        , score_halftime_away
        , referees
        , hometeam_latitude
        , hometeam_longitude
        , awayteam_latitude
        , awayteam_longitude
        , hometeam_european_rank
        , awayteam_european_rank
        , hometeam_ucl_rank
        , awayteam_ucl_rank
        , distance_in_miles
FROM
  intermediate.int_ucl_matches
WHERE 1=1
  AND match_status = 'FINISHED'
  AND match_datetime_est < CURRENT_DATE('America/New_York');