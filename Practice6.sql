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
WHERE job_count > 11;

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
--EX12

