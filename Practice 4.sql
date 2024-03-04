--PRACTICE 4
--EX1
SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views, 
  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views 
FROM viewership;

--EX2
SELECT x, y, z,
    CASE WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' 
    ELSE 'No'
    END AS triangle
FROM Triangle
  
--EX3
SELECT 
ROUND(SUM(CASE WHEN call_category IN ('n/a', NULL) THEN 1 ELSE 0 END)
/ SUM(CASE WHEN call_category NOT IN ('n/a', NULL) THEN 1 ELSE 0 END),1)*100 as call_percentage
FROM callers;
  
--EX4
SELECT name
FROM Customer 
WHERE referee_id != 2 OR referee_id IS NULL;

--EX5
SELECT survived,
SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_classs,
SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY survived

