SELECT * FROM retail_sales
--Q3. write sql query to calculate the total sales (total_sale) for each category
SELECT category,SUM(total_sales) as total_sales_by_cataegory
FROM retail_sales GROUP BY 1;

--Q4. write a sql query to find the average age of customers who purchased 
--items from the 'Beauty' category.
SELECT 
	ROUND(AVG(age),2) as average_age 
FROM 
    retail_sales 
WHERE 
    category = 'Beauty' ;

--Q.5 Write a sql query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales 
WHERE total_sales > 1000;

--Q.6 Write a sql query to find the total number of transactions (id) made by each gender in each category
SELECT
    category,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
    category,
	gender
ORDER BY 1;

--Q.7 write  a sql query to calculate the average sale for each month.
--Find out best selling month in each year.
SELECT 
    year,
	month,
	avg_sales_each_month
FROM
(
SELECT 
    EXTRACT(YEAR FROM sales_date) as year,
	EXTRACT(MONTH FROM sales_date)as month,
    AVG(total_sales) as avg_sales_each_month,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sales_date) ORDER BY AVG(total_sales) DESC) as rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank = 1

--Q.8 write a sql query to find all top 5 customers based on highesht total sales

SELECT 
    customer_id,
    SUM(total_sales) as highest_sales
FROM 
    retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q.9 write a sql query to find the number of unique customers who purchased
--item for each category.
SELECT 
    category,
    COUNT(DISTINCT customer_id) as unique_customers
FROM
    retail_sales
GROUP BY category;	

--Q.10 write a sql query to create each shift and number of orders
--(Example Morning <=12,Afternoon Between 12 & 17, Evening > 17).
WITH hourly_sale
AS
(
SELECT *,
    CASE
	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT 
    shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift
	





	


