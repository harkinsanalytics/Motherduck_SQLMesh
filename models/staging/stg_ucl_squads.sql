MODEL (
    name champions_league_data.staging.stg_ucl_matches
  , kind FULL
  , cron '@weekly'
  , grain id
);

SELECT
          competition_id
        , competition_name
        , competition_code
        , season_id
        , season_startDate as season_start_date
        , season_endDate as season_end_date
        , season_currentMatchday as season_current_matchday
        , id as match_id
        , CAST(CAST(utcDate AS TIMESTAMPTZ) AT TIME ZONE 'America/New_York' AS TIMESTAMP) as match_datetime_est
        , status as match_status
        , matchday
        , stage
        , group
        , lastUpdated
        , homeTeam_id as hometeam_id
        , homeTeam_name as hometeam_name 
        , homeTeam_shortName as hometeam_shortname 
        , homeTeam_tla as hometeam_tla 
        , awayTeam_id as awayteam_id 
        , awayTeam_name awayteam_name 
        , awayTeam_shortName as awayteam_shortname 
        , awayTeam_tla awayteam_tla 
        , score_winner
        , score_duration
        , score_fullTime_home as score_fulltime_home
        , score_fullTime_away as score_fulltime_away 
        , score_halfTime_home as score_halftime_home 
        , score_halfTime_away as score_halftime_away 
        , odds_msg
        , referees
FROM
  champions_league_data.main.champions_league_matches