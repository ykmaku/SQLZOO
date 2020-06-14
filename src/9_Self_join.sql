-- 1
SELECT count(id)
FROM stops

-- 2
SELECT id 
FROM stops
WHERE name='Craiglockhart'

-- 3
SELECT id, name 
FROM stops RIGHT JOIN route
  ON stops.id=route.stop
WHERE route.num='4'
  AND route.company='LRT'

-- 4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)=2

-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route AS a JOIN route AS b
ON a.company=b.company
AND a.num=b.num
WHERE a.stop=(SELECT id FROM stops WHERE name='Craiglockhart')
  AND b.stop=(SELECT id FROM stops WHERE name='London Road')

-- 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
  AND stopb.name='London Road'

-- 7
SELECT DISTINCT a.company, a.num
FROM route AS a JOIN route AS b
  ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=115
  AND b.stop=137

-- 8
SELECT a.company, a.num 
FROM route AS a JOIN route AS b
ON a.company=b.company
AND a.num=b.num
WHERE a.stop=(SELECT id FROM stops WHERE name='Craiglockhart')
  AND b.stop=(SELECT id FROM stops WHERE name='Tollcross')

-- 9
SELECT DISTINCT stops.name, a.company, a.num
FROM route AS a JOIN route AS b ON (a.company=b.company AND a.num=b.num)
    JOIN stops ON (b.stop=stops.id)
WHERE a.stop=(SELECT id FROM stops WHERE name='Craiglockhart')

-- 10
SELECT ra.num, ra.company, stops.name, rc.num, rc.company
FROM (route AS ra JOIN route AS rb ON(ra.company=rb.company AND ra.num=rb.num))
  JOIN (route AS rc JOIN route AS rd ON(rc.company=rd.company AND rc.num=rd.num)) ON (rb.stop=rc.stop)
  JOIN stops ON (rb.stop=stops.id)
WHERE ra.stop=(SELECT id FROM stops WHERE name='Craiglockhart')
  AND rd.stop=(SELECT id FROM stops WHERE name='Lochend')
  AND rb.stop=rc.stop
ORDER BY ra.company, ra.num, stops.name, rc.num, rc.company