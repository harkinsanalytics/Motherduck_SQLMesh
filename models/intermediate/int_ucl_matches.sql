MODEL (
    name champions_league_data.intermediate.int_ucl_matches
  , kind FULL
  , cron '0 12 * * 4'
  , grain match_id
);

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
        , t.latitude as hometeam_latitude
        , t.longitude as hometeam_longitude
        , tt.latitude as awayteam_latitude
        , tt.longitude as awayteam_longitude
        , t.rank as hometeam_rank
        , tt.rank as awayteam_rank 
FROM staging.stg_ucl_matches m
JOIN intermediate.int_ucl_teams t 
ON m.hometeam_id = t.team_id 
JOIN intermediate.int_ucl_teams tt 
ON m.awayteam_id = tt.team_id 