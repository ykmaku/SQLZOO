-- 1
SELECT matchid, player
FROM goal
WHERE teamid = 'GER'

-- 2
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012

-- 3
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (game.id=goal.matchid)
WHERE teamid = 'GER'

-- 4
SELECT team1, team2, player
FROM game JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%'

-- 5
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON goal.teamid = eteam.id
WHERE gtime<=10

-- 6
SELECT game.mdate, eteam.teamname
FROM game JOIN eteam ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos'

-- 7
SELECT goal.player
FROM goal JOIN game ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw'

-- 8
SELECT DISTINCT goal.player
FROM goal JOIN game ON goal.matchid = game.id
WHERE goal.teamid != 'GER'
  AND ((game.team1 = 'GER') OR (game.team2 = 'GER'))

-- 9
SELECT teamname, COUNT(*) AS TOTAL_GOAL
FROM goal JOIN eteam ON goal.teamid = eteam.id
GROUP BY teamname

-- 10
SELECT game.stadium, count(*)
FROM goal JOIN game ON goal.matchid = game.id
GROUP BY game.stadium

-- 11
SELECT game.id, game.mdate, count(*)
FROM goal JOIN game ON goal.matchid = game.id
WHERE game.team1 = 'POL' OR game.team2 = 'POL'
GROUP BY game.id

-- 12
SELECT game.id, game.mdate, count(*)
FROM goal JOIN game ON goal.matchid = game.id
WHERE goal.teamid = 'GER'
GROUP BY game.id
HAVING COUNT(*) > 0

-- 13
-- LEFT JOINでないと 0-0 のゲームが消えてしまう
SELECT
    game.mdate, 
    game.team1, 
    SUM(CASE WHEN goal.teamid = team1 THEN 1
               ELSE 0
          END) AS score1, 
    game.team2,
    SUM(CASE WHEN goal.teamid = team2 THEN 1
               ELSE 0
          END) AS score2
FROM game LEFT JOIN goal ON goal.matchid = game.id
GROUP BY game.id
ORDER BY game.mdate, game.id, game.team1, game.team2