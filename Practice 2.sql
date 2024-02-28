--EX1
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0
ORDER BY CITY;

--EX2
SELECT COUNT(*) - COUNT(DISTINCT CITY) AS 'Difference'
FROM STATION

--EX3
--EX4
SELECT ROUND(CAST(sum(item_count * order_occurrences)/sum(order_occurrences) as DECIMAL),1) as mean
FROM items_per_order
GROUP BY item_count;

--EX5
SELECT candidate_id 
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3;

--EX6
SELECT user_id, DATE(MAX(post_date::date)) - DATE(MIN(post_date::date)) AS days_between
FROM posts
WHERE DATE_PART('year', post_date::date) = 2021
GROUP BY user_id
HAVING COUNT(post_id) >= 2;

--EX7
SELECT card_name, MAX(issued_amount) - MIN(issued_amount) AS difference 
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;

--EX8
SELECT manufacturer, COUNT(drug) AS drug_count, ABS(SUM(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE total_sales - cogs <= 0
GROUP BY manufacturer;

--EX9
SELECT *
FROM CINEMA
WHERE ID % 2 != 0 AND DESCRIPTION <> 'Boring'
ORDER BY rating DESC;

--EX10
SELECT teacher_id, COUNT(DISTINCT  subject_id) AS cnt
FROM TEACHER
GROUP BY teacher_id
ORDER BY subject_id DESC

--EX11
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;

--EX12
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5; 
