-- Modify it to show the matchid and player name for all goals scored by Germany. 
-- To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';

-- Show id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2
  FROM game
 WHERE id = 1012;

-- Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT goal.player, goal.teamid, game.stadium, game.mdate
  FROM game JOIN goal ON (game.id=goal.matchid)
WHERE goal.teamid = 'GER';

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT m.team1, m.team2, g.player
  FROM game as m JOIN goal AS g ON (m.id=g.matchid)
WHERE player LIKE 'Mario%';

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT g.player, g.teamid, t.coach, g.gtime
  FROM goal AS g JOIN eteam AS t
    ON g.teamid = t.id
 WHERE gtime<=10;

-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT m.mdate, t.teamname
  FROM game AS m JOIN eteam AS t
    ON m.team1 = t.id
 WHERE t.coach = 'Fernando Santos';

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT g.player
  FROM goal AS g JOIN game AS m
    ON m.id = g.matchid
 WHERE m.stadium = 'National Stadium, Warsaw';

-- Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT g.player
  FROM game AS m JOIN goal AS g
   ON g.matchid = m.id 
 WHERE (m.team1='GER' OR m.team2='GER')
  AND g.teamid != 'GER';

-- Show teamname and the total number of goals scored.
SELECT t.teamname, COUNT(g.gtime) 
  FROM eteam AS t JOIN goal AS g
   ON t.id=g.teamid
 GROUP BY t.teamname
 ORDER BY t.teamname;

-- Show the stadium and the number of goals scored in each stadium.
SELECT m.stadium, COUNT(g.gtime) 
  FROM game AS m JOIN goal AS g
   ON m.id=g.matchid
 GROUP BY m.stadium
 ORDER BY m.stadium;

-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, count(player)
FROM game join goal on id = matchid
WHERE (team1 = 'POL' or team2 = 'POL')
GROUP BY matchid, mdate

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT g.matchid, m.mdate, COUNT(g.gtime)
  FROM game AS m JOIN goal AS g ON g.matchid = m.id 
 WHERE teamid = 'GER'
GROUP BY m.id;

-- Sort your result by mdate, matchid, team1 and team2.
SELECT m.mdate,
  m.team1,
  SUM(CASE WHEN g.teamid=m.team1 THEN 1 ELSE 0 END) AS score1,
  m.team2,
  SUM(CASE WHEN g.teamid=m.team2 THEN 1 ELSE 0 END) AS score2
 FROM game AS m LEFT JOIN goal AS g ON g.matchid = m.id
 GROUP BY m.id
 ORDER BY mdate, matchid, team1, team2;
