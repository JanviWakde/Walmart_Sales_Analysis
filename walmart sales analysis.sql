-- Walmart Sales Data Analysis

create database salesDataWalmart;

use salesDataWalmart;

create table sales(
  invoice_id varchar(30) not null primary key,
  branch varchar(5) not null,
  city varchar(30) not null,
  customer varchar(30) not null,
  gender varchar(10) not null,
  product_line varchar(100) not null,
  unit_price decimal(10,2) not null,
  quantity int not null,
  VAT float(6,4) not null,
  total decimal(12,4) not null,
  date datetime not null,
  time time not null,
  payment_method varchar(15) not null,
  cogs decimal(10,2) not null,
  gross_margin_pct float(11,9) not null,
  gross_income decimal(12,4) not null,
  rating float(2,1) 
);  

select * from sales;

-- adding new column using existing one

-- time_of_day 
select 
      time,
      (case
          when `time` between "00:00:00" and "12:00:00" then "Morning"
          when `time` between "12:01:00" and "16:00:00" then "Afternoon"
          else "Evening"
       end   
      ) as time_of_day
from sales; 

alter table sales add column time_of_day varchar(20);  

update sales 
set time_of_day = (
	case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
		when `time` between "12:01:00" and "16:00:00" then "Afternoon"
		else "Evening"
	end 
);

-- day_name
select 
	date,
    dayname(date) as day_name
from sales;    

alter table sales add column day_name varchar(10);

update sales
set day_name = dayname(date);

-- month_name
select 
    date,
	monthname(date) as month_name
from sales;

alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(date);


-- How many unique does the data have?
select distinct city 
from sales;

-- In which city is each branch?
select distinct city, branch
from sales;



-- Product Analysis
-- 1. How many unique product lines does the data have?
select count(distinct product_line)
from sales;

-- 2. What is the most common payment method?
select payment_method,
  count(payment_method) as cpm
from sales
group by payment_method
order by cpm desc;

-- 3. What is the most selling product line? 
select product_line,
    count(product_line) as msp  
from sales
group by product_line
order by msp desc;

-- 4. What is the total revenue by month?
select 
    month_name as month,
    sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc;    

-- 5. What month had the largest COGS?
select 
   month_name as month,
   sum(cogs) as cogs
from sales
group by month_name
order by cogs desc;   

-- 6. What product line had the largest revenue?
select 
    product_line,
    sum(total) as total_revenue
from sales 
group by product_line
order by total_revenue desc;

-- 7. What is the city with the largest revenue?
select 
    city,
    sum(total) as total_revenue
from sales 
group by city
order by total_revenue desc;    

-- 8. What product line had the largest VAT?
select
    product_line,
    avg(VAT) as avg_tax
from sales
group by product_line
order by avg_tax desc;    

-- 9. Which branch sold more products than average product sold?
select 
    branch,
    sum(quantity) as qty
from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);    

-- 10. What is the most common product line by gender?
select 
    gender,
    product_line,
    count(gender) as total_cnt
 from sales
 group by gender, product_line
 order by total_cnt desc;
 
 -- 11. What is the average rating of each product line?
 select 
     avg(rating) as avg_rating,
     product_line 
from sales
group by product_line
order by avg_rating desc;



-- Sales Analysis
-- 1. Number of sales made in each time of the day per weekday
select 
    time_of_day,
    count(*) as total_sales
from sales
where day_name = "Sunday"
group by time_of_day
order by total_sales desc;

-- 2. Which of the customer types brings the most revenue?
select 
    customer,
    sum(total) as total_rev
from sales
group by customer
order by total_rev desc; 

-- 3. Which city has the largest tax percent/ VAT (Value Added Tax)?
select 
    city,
    avg(VAT) as VAT
from sales
group by city
order by VAT desc;    

-- 4. Which customer type pays the most in VAT?
select 
    customer,
    avg(VAT) as VAT
from sales
group by customer
order by VAT desc;



-- Customer Analysis
-- 1. How many unique customer types does the data have?
select
   count(distinct customer) 
from sales;   

-- 2. How many unique payment methods does the data have?
select
   count(distinct payment_method) 
from sales; 

-- 3. What is the most common customer type?
select
   customer,
   count(*) as count
from sales
group by customer
order by count desc;   

-- 4. Which customer type buys the most?
select 
   customer,
   sum(quantity) as toatl_item_bought
from sales
group by customer
order by toatl_item_bought desc;  

-- 5. What is the gender of most of the customers?
SELECT 
    gender, 
    COUNT(*) AS count
FROM sales
GROUP BY gender
ORDER BY count DESC;


-- 6. What is the gender distribution per branch?
SELECT 
    branch, 
    gender, 
    COUNT(*) AS count
FROM sales
GROUP BY branch, gender
ORDER BY branch, count DESC;


-- 7. Which time of the day do customers give most ratings?
SELECT 
    time_of_day,
    COUNT(*) AS rating_count
FROM (
    SELECT 
        CASE
            WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
            WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
            ELSE 'Evening'
        END AS time_of_day
    FROM sales
) AS time_groups
GROUP BY time_of_day
ORDER BY rating_count DESC;

-- 8. Which time of the day do customers give most ratings per branch?
SELECT 
    branch,
    time_of_day,
    COUNT(*) AS rating_count
FROM (
    SELECT 
        branch,
        CASE
            WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
            WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
            ELSE 'Evening'
        END AS time_of_day
    FROM sales
) AS sub
GROUP BY branch, time_of_day
ORDER BY branch, rating_count DESC;

-- 9. Which day fo the week has the best avg ratings?
SELECT 
    DAYNAME(date) AS day_of_week,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY day_of_week
ORDER BY avg_rating DESC;

-- 10. Which day of the week has the best average ratings per branch?
SELECT 
    branch,
    DAYNAME(date) AS day_of_week,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, day_of_week
ORDER BY branch, avg_rating DESC;


  