--PRACTICE 5
--EX1
SELECT CONTINENT, AVG(CI.POPULATION) AS AVG_POPULATION
FROM COUNTRY COUN
INNER JOIN CITY CI ON COUN.CODE = CI.COUNTRYCODE
GROUP BY CONTINENT;

--EX2
SELECT ROUND(COUNT(t.email_id)/COUNT(e.email_id),2) AS activation_rate
FROM emails e
LEFT JOIN texts t
  ON e.email_id = t.email_id
WHERE t.signup_action = 'Confirmed';

--EX3
SELECT 
    age_bucket, 
    ROUND(100.0* SUM(CASE WHEN "activity_type" = 'send' THEN act.time_spent ELSE NULL END) / SUM(CASE WHEN "activity_type" IN ('send','open') THEN "time_spent" ELSE NULL END), 2) AS send_perc,
    ROUND(100.0* SUM(CASE WHEN "activity_type" = 'open' THEN act.time_spent ELSE NULL END) / SUM(CASE WHEN "activity_type" IN ('send', 'open') THEN "time_spent" ELSE NULL END), 2) AS open_perc
FROM 
    activities act 
INNER JOIN 
    age_breakdown age_ ON act.user_id = age_.user_id
GROUP BY 
    age_bucket;


--EX4?
SELECT customer_id,
COUNT(DISTINCT product_category) AS product_
FROM customer_contracts cus
INNER JOIN products pro ON cus.product_id = pro.product_id
GROUP BY customer_id;


--EX5
SELECT E1.employee_id , E1.name,
COUNT(E2.reports_to) AS reports_count,
ROUND(AVG(E2.age),0) AS average_age    
FROM Employees E1
INNER JOIN Employees E2 ON E1.employee_id  = E2.reports_to
GROUP BY E1.employee_id , E1.name

--EX6
SELECT P.product_name, SUM(O.unit) AS unit
FROM Orders O
INNER JOIN Products P ON O.product_id = P.product_id
WHERE EXTRACT(MONTH FROM O.order_date) = 2
        AND EXTRACT(YEAR FROM O.order_date) = 2020
GROUP BY P.product_name
HAVING SUM(O.unit) > 100
ORDER BY P.product_name;

--EX7
SELECT pg.page_id
FROM pages pg
LEFT JOIN page_likes pl 
ON pg.page_id = pl.page_id
WHERE pl.page_id IS NULL; 
