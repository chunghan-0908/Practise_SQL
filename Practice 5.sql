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
