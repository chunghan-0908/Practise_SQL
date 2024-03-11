--PRACTICE 6
--EX1
WITH job_CTE AS (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) 
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_CTE
WHERE job_count > 1;

--EX2
WITH cte_top2_product 
AS (SELECT product, SUM(spend) as Revenue
    FROM product_spend
    GROUP BY product)
SELECT category, a.product, Revenue
FROM product_spend a
INNER JOIN cte_top2_product b ON a.product = b.product
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
LIMIT 2;

--EX3
WITH cte_inf_caller 
AS (SELECT policy_holder_id, COUNT(case_id) AS count_Case
    FROM callers
    GROUP BY policy_holder_id)
SELECT COUNT(*) 
FROM cte_inf_caller
WHERE count_Case >= 3

--EX4
WITH PageLikesCount AS (
    SELECT p.page_id, COUNT(pl.user_id) AS like_count
    FROM pages p
    LEFT JOIN page_likes pl ON p.page_id = pl.page_id
    GROUP BY p.page_id
)
SELECT page_id
FROM PageLikesCount
WHERE like_count = 0
ORDER BY page_id ASC;

--EX5?
WITH cte_count_user 
AS (SELECT EXTRACT(MONTH FROM a1.event_date) AS month, a1.user_id
FROM user_actions a1 
WHERE EXTRACT(MONTH FROM a1.event_date) = 7 AND user_id IN (SELECT a2.user_id
                                                          FROM user_actions a2
                                                          WHERE a1.user_id = a2.user_id 
                                                          AND EXTRACT(MONTH FROM a2.event_date) = 6
                                                          )
GROUP BY EXTRACT(MONTH FROM a1.event_date), a1.user_id)
SELECT month, COUNT(user_id) AS monthly_active_users
FROM cte_count_user
GROUP BY month

--EX6
SELECT CONCAT(YEAR(trans_date),'-',MONTH(trans_date)) AS month, country, 
COUNT(id) AS trans_count, 
SUM(CASE WHEN state = 'approved' then 1 else 0 END) as approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state = 'approved' then amount else 0 END) as approved_total_amount
FROM Transactions
GROUP BY month, country       


--EX7
  --c1
SELECT product_id, MIN(year) AS first_year,  quantity, price
FROM Sales
GROUP BY product_id
  
  --c2
SELECT product_id, year as first_year, quantity, price
FROM Sales
WHERE year IN (SELECT MIN(year)
               FROM Sales
               GROUP BY product_id)

--EX8
  --1
SELECT customer_id
FROM (
    SELECT customer_id, COUNT(DISTINCT product_key) AS num_products_bought
    FROM Customer
    GROUP BY customer_id
) AS CustomerProductCount
WHERE num_products_bought = (SELECT COUNT(*) FROM Product);

  --2
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)

--EX9
SELECT employee_id
FROM employees
WHERE salary < 30000 AND manager_id NOT IN (SELECT employee_id FROM employees) 
ORDER BY employee_id;

--EX10
WITH job_CTE AS (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) 

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_CTE 
WHERE job_count > 1

--EX11
WITH 
cte_1 AS (
    SELECT u.name as results, COUNT(m1.rating) as count_rating
    FROM MovieRating m1
    INNER JOIN Users u ON m1.user_id = u.user_id
    GROUP BY u.name
    ORDER BY COUNT(m1.rating) DESC, u.name
    LIMIT 1
),
cte_2 AS (
    SELECT m3.title, AVG(m2.rating) as avg_rating
    FROM MovieRating m2
    INNER JOIN Movies m3 ON m2.movie_id = m3.movie_id
    WHERE EXTRACT(YEAR FROM m2.created_at) = 2020 
        AND EXTRACT(MONTH FROM m2.created_at) = 2 
    ORDER BY AVG(m2.rating) DESC, m3.title
    LIMIT 1
)
SELECT results FROM cte_1 
UNION ALL 
SELECT title FROM cte_2;

--EX12
WITH cte AS (
    SELECT requester_id AS id, COUNT(accepter_id) AS num
    FROM RequestAccepted
    GROUP BY requester_id
    UNION ALL 
    SELECT accepter_id AS id, COUNT(accepter_id) AS num
    FROM RequestAccepted
    GROUP BY accepter_id
  )
SELECT id, SUM(num) as num 
FROM cte
GROUP BY id
ORDER BY SUM(num) DESC
LIMIT 1

