drop database if exists pizza_sales;

create database pizza_sales;

use pizza_sales;



-- 1. Total Revenue: The sum of the total price of all pizza orders. 

select round(sum(total_price),2) as Total_Revenue 
from pizza_sales;

-- 2. Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders.

select round(sum(total_price)/count(distinct order_id),2) as Average_Order_Value
from pizza_sales;


-- 3. Total Pizzas Sold: The sum of the quantities of all pizzas sold.

select sum(quantity) as Total_Pizzas_Sold 
from pizza_sales;


-- 4. Total Orders: The total number of orders placed.

select count(distinct order_id) as Total_Orders 
from pizza_sales;


-- 5. Average Pizzas per Order: The average number of pizzas sold per order, 
--  calculated by dividing the total number of pizzas sold by the total number of orders.

select sum(quantity)/count(distinct order_id)  as Avg_Pizzas_per_Order 
from pizza_sales;


-- 6. Daily Trend for Total Orders:

SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_Day, 
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));


-- 7. Monthly Trend for Total Orders:

select monthname(STR_TO_DATE(order_date,'%d-%m-%y')) as Order_Month , count(distinct order_id) as Total_Order
from pizza_sales
group by monthname(STR_TO_DATE(order_date,'%d-%m-%y'));


-- 8. Percentage of Sales by Pizza Category:

select pizza_category,  round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_category;

-- 8.A) i want to find out percentage of sales by pizza category in January month
select pizza_category,  round(sum(total_price)*100/(select sum(total_price) from pizza_sales where month(str_to_date(order_date,'%d-%m-%y')) = 1),2) as PCT
from pizza_sales
where month(str_to_date(order_date,'%d-%m-%y')) = 1
group by pizza_category;

-- 8.B) i want to find out percentage of sales by pizza category in second Quarter

select pizza_category,  round(sum(total_price)*100/(select sum(total_price) from pizza_sales where quarter(str_to_date(order_date,'%d-%m-%y')) = 1),2) as PCT
from pizza_sales
where quarter(str_to_date(order_date,'%d-%m-%y')) = 2
group by pizza_category;


-- 9. Percentage of Sales by Pizza Size:

select pizza_size , round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_size;

-- 10. Total Pizzas Sold by Pizza Category:


select pizza_category , sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_category;



-- 11. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders:

-- by Revenue

select pizza_name, sum(total_price) as Total_Revenue 
from pizza_sales
group by pizza_name
order by Total_Revenue desc
limit 5;

-- by Quantity
select pizza_name , sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity desc
limit 5;


-- by Orders

select pizza_name , count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders desc
limit 5;


-- 12. Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders:

-- by Revenue

select pizza_name, round(sum(total_price),2) as Total_Revenue 
from pizza_sales
group by pizza_name
order by Total_Revenue asc
limit 5;


-- by Quantity

select pizza_name , sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity asc
limit 5;

-- by Orders

select pizza_name , count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders asc
limit 5;







   




