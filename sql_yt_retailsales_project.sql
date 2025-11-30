SELECT * FROM yt_sql_project1.retail_sales
limit 10
 ;
 select count(*) from retail_sales;
 select * from retail_sales where transactions_id is null;
 select * from retail_sales where sale_date is null;
 select * from retail_sales where sale_time is null;
 select * from retail_sales where customer_id is null;
 select * from retail_sales where gender is null;
 select * from retail_sales where age is null;
 select * from retail_sales where category is null;
 select * from retail_sales where quantiy is NULL;
 select * from retail_sales where price_per_unit is null;
 select * from retail_sales where cogs is null;
 select * from retail_sales where total_sale is null;
 select * from retail_sales where
  transactions_id is null 
  or sale_date is null
  or sale_time is null
  or customer_id is null
  or gender is null
  or age is  null
  or quantiy is null
  or category is null
  or price_per_unit is null 
  or cogs is null 
  or total_sale is null;
  
  -- data exploration
  -- how many unique customers are there?
  select count(distinct customer_id) from retail_sales;
  -- how many sales we have?
  select count(*) from retail_sales;
-- What are the differnt categories?
select distinct category from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales
 where category='Clothing'
and sale_date between '2022-11-01' and '2022-11-30'
and quantity>=4;
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, 
sum(total_sale) as net_sales,
count(*) as total_orders
 from retail_sales group by category;
 
 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as avg_age
from retail_sales where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale >1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select   category,gender,count(transactions_id) from retail_sales group by category, gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from  
(select YEAR(sale_date) as year , month(sale_date) as month,
 avg(total_sale),
 rank() over(partition by YEAR(sale_date) order by avg(total_sale) desc) as rank_in_year
from retail_sales
group by YEAR(sale_date), month(sale_date))as t where rank_in_year=1 ;
-- order by desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) as total_sale from retail_sales 
group by customer_id order by sum(total_sale) desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select   count(distinct customer_id) as no_of_customers ,
 category  from retail_sales
 group by category;
 
 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 select count(transactions_id), shift from 
 (select *,
 case
 when hour(sale_time)<12 then 'Morning'
 when hour(sale_time)>=12 and hour(sale_time)<=17 then 'Afternoon'
 when hour(sale_time)>17 then 'Evening'
 end as shift
 from retail_sales)as  t
 group by shift;

-- end of project