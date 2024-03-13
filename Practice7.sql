--Practice 7
--EX1
WITH cte_spend_year 
AS (SELECT EXTRACT(YEAR FROM transaction_date) AS yr, product_id, spend AS curr_year_spend,
    LAG(spend, 1) OVER (PARTITION BY product_id 
                        ORDER BY product_id, EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend
    FROM user_transactions)
SELECT *, ROUND(100* (curr_year_spend - prev_year_spend)/prev_year_spend,2) AS yoy_rate 
FROM cte_spend_year

--EX2
with cte_launch_date 
AS (SELECT card_name, issued_amount, 
FIRST_VALUE(issue_month || '-' || issue_year) OVER(PARTITION BY card_name ORDER BY issued_amount) as launch_date
FROM monthly_cards_issued)
SELECT card_name, issued_amount
FROM cte_launch_date
ORDER BY issued_amount DESC;

--EX3
WITH cte_third_trans
AS (SELECT user_id, spend, transaction_date,
ROW_NUMBER() OVER(PARTITION BY user_id) AS row_num
FROM transactions)
SELECT user_id, spend, transaction_date
FROM cte_third_trans
WHERE row_num = 3;

--EX4
WITH cte_rank_date
AS (SELECT transaction_date, user_id, product_id,
RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS days_rank 
FROM user_transactions)
SELECT transaction_date, user_id, COUNT(product_id) as purchase_count  
FROM cte_rank_date
WHERE days_rank = 1
GROUP BY transaction_date, user_id
ORDER BY transaction_date, user_id;

--EX5?
--EX6
--EX7
WITH cte_top2_product 
AS (SELECT product, 
SUM(spend) OVER (PARTITION BY category) as total_spend 
    FROM product_spend
    )
SELECT category, a.product, total_spend
FROM product_spend a
INNER JOIN cte_top2_product b 
  ON a.product = b.product
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
ORDER BY total_spend DESC
LIMIT 2;

--EX8


