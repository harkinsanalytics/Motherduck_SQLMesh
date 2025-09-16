MODEL (
    name champions_league_data.facts.fct_ucl_league_standings
  , kind FULL
  , cron '0 8 * * 3,4,5'
  , grain match_id
);

WITH hometeam as (
SELECT 
      match_id
    , match_status
    , matchday
    , season_current_matchday
    , hometeam_id as team_id
    , hometeam_tla as team_tla
    , 'HOME_TEAM' as home_away
    , score_fulltime_home as score_fulltime
    , score_halftime_home as score_halftime
    , score_winner
FROM intermediate.int_ucl_matches
WHERE 1=1
AND stage = 'LEAGUE_STAGE'
)

, awayteam as (
SELECT 
      match_id
    , match_status
    , matchday
    , season_current_matchday
    , awayteam_id as team_id
    , awayteam_tla as team_tla
    , 'AWAY_TEAM' as home_away
    , score_fulltime_away as score_fulltime
    , score_halftime_away as score_halftime
    , score_winner
FROM intermediate.int_ucl_matches
WHERE 1=1
AND stage = 'LEAGUE_STAGE'
)

, unioned_data as (
SELECT *
FROM hometeam
UNION ALL
SELECT *
FROM awayteam
)

, points as (
SELECT 
    ud.match_id
  , ud.matchday
  , ud.team_id
  , ud.team_tla
  , t.team_name
  , ud.home_away
  , ud.score_fulltime
  , ud.score_winner
  , ud.match_status 
  , sum(CAST(ud.score_halftime as int)) OVER (PARTITION BY ud.team_id ORDER BY ud.matchday ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as halftime_goals_scored
  , sum(CAST(ud.score_fulltime as int)) OVER (PARTITION BY ud.team_id ORDER BY ud.matchday ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as total_goals_scored
  , CASE WHEN ud.score_winner = ud.home_away THEN 3
         WHEN ud.score_winner = 'DRAW' THEN 1
         ELSE 0 END as points_earned
FROM unioned_data ud      
LEFT JOIN intermediate.int_ucl_teams t  
ON ud.team_id = t.team_id
WHERE 1=1
)

, goals_conceded as (
SELECT
      p.*
    , sum(cast(p.points_earned as int)) OVER (PARTITION BY p.team_id ORDER BY p.matchday ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as total_points_earned
    , pp.score_fulltime as goals_conceded
    , sum(cast(pp.score_fulltime as int)) OVER (PARTITION BY p.team_id ORDER BY p.matchday ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as total_goals_conceded
FROM points p
JOIN points pp 
ON p.match_id = pp.match_id AND p.team_id != pp.team_id
)

SELECT 
      matchday
    , match_status 
    , team_tla 
    , team_name 
    , total_points_earned
    , total_goals_scored
    , total_goals_conceded
    , (total_goals_scored-total_goals_conceded) as goal_differential
    , max(matchday) OVER (ORDER BY matchday DESC) as max_matchday
FROM goals_conceded
WHERE 1=1
AND match_status = 'FINISHED'
ORDER BY 1, 4 DESC, 7 DESC, 5 DESC, 3