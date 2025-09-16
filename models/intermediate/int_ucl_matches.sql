MODEL (
    name champions_league_data.intermediate.int_ucl_matches
  , kind FULL
  , cron '0 8 * * 3,4,5'
  , grain match_id
);

WITH t1 as (
SELECT 
          m.competition_id
        , m.competition_name
        , m.competition_code
        , m.season_id
        , m.season_start_date
        , m.season_end_date
        , m.season_current_matchday
        , m.match_id
        , m.match_datetime_est
        , m.match_status
        , m.matchday
        , m.stage
        , m.group
        , m.lastupdated
        , m.hometeam_id
        , m.hometeam_name
        , m.hometeam_shortname
        , m.hometeam_tla
        , m.awayteam_id
        , m.awayteam_name
        , m.awayteam_shortname
        , m.awayteam_tla
        , m.score_winner
        , m.score_duration
        , m.score_fulltime_home
        , m.score_fulltime_away
        , m.score_halftime_home
        , m.score_halftime_away
        , m.referees
        , l.latitude as hometeam_latitude
        , l.longitude as hometeam_longitude
        , ll.latitude as awayteam_latitude
        , ll.longitude as awayteam_longitude
        , t.european_rank as hometeam_european_rank
        , tt.european_rank as awayteam_european_rank 
        , t.ucl_rank as hometeam_ucl_rank
        , tt.ucl_rank as awayteam_ucl_rank
FROM staging.stg_ucl_matches m
LEFT JOIN intermediate.int_ucl_teams t 
ON m.hometeam_id = t.team_id 
LEFT JOIN intermediate.int_ucl_teams tt 
ON m.awayteam_id = tt.team_id 
LEFT JOIN staging.stg_ucl_latlong l 
ON m.hometeam_id = l.team_id 
LEFT JOIN staging.stg_ucl_latlong ll 
ON m.awayteam_id = ll.team_id 
)

SELECT
        * 
      , round(3959 * 2 * ASIN(
        SQRT(
            POWER(SIN(RADIANS(awayteam_latitude - hometeam_latitude) / 2), 2) +
            COS(RADIANS(hometeam_latitude)) *
            COS(RADIANS(awayteam_latitude)) *
            POWER(SIN(RADIANS(awayteam_longitude - hometeam_longitude) / 2), 2)
        )),2) AS distance_in_miles
FROM t1