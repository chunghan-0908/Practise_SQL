--practice 3
--EX1
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT(Name, 3), ID ASC

--EX2 
SELECT user_id, CONCAT(UPPER(LEFT(name,1)), LOWER(RIGHT(name,LENGTH(name) - 1))) as name
FROM Users
ORDER BY user_id;

--EX3
SELECT manufacturer, '$ ' || ROUND(SUM(total_sales)/1000000, 0) || ' million' AS salesale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC;

--EX4
SELECT EXTRACT(month FROM submit_date) as mth, product_id, ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY product_id, EXTRACT(month FROM submit_date)
ORDER BY EXTRACT(month FROM submit_date), product_id;

--EX5
SELECT sender_id, COUNT(message_id) AS message_count
FROM messages 
WHERE EXTRACT(YEAR FROM sent_date) = '2022'
      AND EXTRACT(MONTH FROM sent_date) = '08'
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
LIMIT 2;

--EX6
SELECT tweet_id 
FROM Tweets
WHERE LENGTH(content) > 15
ORDER BY tweet_id


--EX7
  --1
SELECT activity_date as day, COUNT(DISTINCT user_id) as active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date
ORDER BY activity_date;
 --2
SELECT activity_date as day, COUNT(DISTINCT user_id) as active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date
ORDER BY activity_date;


--EX8
SELECT COUNT(id) as number_of_employees_hired 
FROM employees
WHERE EXTRACT(YEAR FROM joining_date) = '2022'
    AND EXTRACT(MONTH FROM joining_date) BETWEEN 01 AND 07;

--EX9
SELECT POSITION('a' IN first_name)
FROM worker
WHERE first_name = 'Amitah'

--EX10
SELECT SUBSTRING(title, LENGTH(winery)+2,4)
FROM winemag_p2
WHERE country = 'Macedonia'

