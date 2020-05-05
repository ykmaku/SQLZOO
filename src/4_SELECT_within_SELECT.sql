-- 1
SELECT name
FROM world
WHERE population >
    (SELECT population
     FROM world
     WHERE name='Russia')

-- 2
SELECT name
FROM world
WHERE gdp / population >
    (SELECT gdp / population
     FROM world
     WHERE name='United Kingdom')
  AND continent = 'Europe'

-- 3
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent
                    FROM world
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name

-- 4
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name='Canada')
  AND population < (SELECT population FROM world WHERE name='Poland')

-- 5
SELECT name,
       CONCAT(ROUND(100 * population / (SELECT population FROM world WHERE name='Germany')), '%')  AS percentage
FROM world
WHERE continent = 'Europe'

-- 6
SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe')

-- 7
SELECT world.continent, world.name, world.area
FROM world,
     (SELECT continent, MAX(area) AS area
      FROM world
      GROUP BY continent) AS w_max
WHERE world.continent = w_max.continent
  AND world.area = w_max.area

SELECT w1.continent, w1.name, w1.area
FROM world AS w1
  LEFT JOIN world AS w2
         ON w1.continent = w2.continent
        AND w1.area < w2.area
WHERE w2.area IS NULL

-- 8
SELECT continent, name
FROM (SELECT continent, name, RANK() OVER(PARTITION BY continent ORDER BY name) AS rank
      FROM world) AS w
WHERE rank = 1

SELECT continent, name
FROM world x
WHERE name <= ALL(SELECT name FROM world y WHERE x.continent = y.continent);

-- 9
SELECT name, continent, population
FROM world
WHERE continent IN (SELECT continent
                    FROM world
                    GROUP BY continent
                    HAVING MAX(population) <= 25000000)

-- 10
SELECT name, continent
FROM world AS w1
WHERE population > ALL(SELECT 3*population
                       FROM world AS w2
                       WHERE w1.continent = w2.continent
                         AND w1.name != w2.name)