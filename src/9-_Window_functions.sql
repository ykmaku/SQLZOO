-- 1
SELECT lastName, party, votes
FROM ge
WHERE constituency='S14000024'
  AND yr=2017
ORDER BY votes DESC

-- 2
SELECT party,
       votes,
       RANK() OVER (ORDER BY votes DESC) AS posn
FROM ge 
WHERE constituency='S14000024'
  AND yr=2017
ORDER BY party

-- 3
SELECT yr,
       party,
       votes,
       RANK() OVER (PARTITION BY yr ORDER BY votes DESC) AS posn 
FROM ge 
WHERE constituency='S14000021'
ORDER BY party, yr

-- 4
SELECT constituency,
       party,
       votes, 
       RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
FROM ge
WHERE yr=2017
  AND constituency BETWEEN 'S14000021' AND 'S14000026'
ORDER BY posn, constituency

-- 5
SELECT constituency, party
FROM (
    SELECT constituency,
        party,
        votes,
        RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
    FROM ge
    WHERE yr=2017
    AND constituency BETWEEN 'S14000021' AND 'S14000026') AS t
WHERE t.posn=1

-- 6
SELECT  party, count(*)
FROM (
    SELECT constituency,
        party,
        votes,
        RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
    FROM ge
    WHERE yr=2017
    AND constituency LIKE 'S%') AS t
WHERE t.posn=1
GROUP BY party 