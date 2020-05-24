-- 1
SELECT id, title
FROM movie
WHERE yr=1962

-- 2
SELECT yr
FROM movie
WHERE title='Citizen Kane'

-- 3
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- 4
SELECT id
FROM actor
WHERE name= 'Gleen Close'

-- 5
SELECT id
FROM movie
WHERE title='Casablanca'

-- 6
SELECT a.name
FROM actor AS a
JOIN (
    SELECT actorid
    FROM casting
    WHERE movieid IN (SELECT id FROM movie WHERE title='Casablanca')) AS c
ON a.id=c.actorid

-- 7
SELECT a.name
FROM actor AS a
JOIN (
    SELECT actorid
    FROM casting
    WHERE movieid IN (SELECT id FROM movie WHERE title='Alien')) AS c
ON a.id=c.actorid

-- 8
SELECT title
FROM movie
WHERE id IN (
    SELECT movieid
    FROM casting
    JOIN actor
    ON actor.name='Harrison Ford' AND actor.id=casting.actorid
)
ORDER BY yr

-- 9
SELECT title
FROM movie
WHERE id IN(
    SELECT movieid
    FROM casting
    JOIN actor
    ON actor.name='Harrison Ford'
    AND casting.ord<>1
    AND actor.id=casting.actorid
)
ORDER BY yr

-- 10
SELECT m.title, a.name
FROM movie AS m
JOIN casting AS c ON m.id=c.movieid
JOIN actor AS a ON c.ord=1 AND c.actorid=a.id
WHERE yr=1962

-- 11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1

-- 12
SELECT title, name
FROM movie JOIN casting ON id=movieid AND ord=1
           JOIN actor ON id=actorid
WHERE movieid IN(
    SELECT movieid
    FROM casting
    WHERE actorid IN(
        SELECT id
        FROM actor
        WHERE name='Julie Andrews'
    )
)

-- 13
SELECT a.name
FROM casting AS c
JOIN actor AS a
  ON c.actorid=a.id
 AND c.ord=1
GROUP BY a.name
HAVING COUNT(*) >= 15

-- 14
SELECT m.title, COUNT(*)
FROM movie AS m
JOIN casting AS c
  ON m.id=c.movieid
WHERE m.yr=1978
GROUP BY m.title
ORDER BY COUNT(*) DESC, title

-- 15
WITH tmp AS(
    SELECT movieid, actorid, name
    FROM casting
    JOIN actor 
      ON casting.actorid=actor.id
)
SELECT DISTINCT name
FROM tmp
WHERE name IN (
    SELECT name
    FROM tmp
    WHERE movieid IN(
        SELECT movieid
        FROM tmp
        WHERE name='Art Garfunkel'
    )
)
AND name!='Art Garfunkel'