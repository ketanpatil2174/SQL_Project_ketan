-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

select * from retail_sales
limit 10;

select count(*) from retail_sales

--finding null vales--
select * from retail_sales 
where transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

--delete null values
delete  from retail_sales
where transaction_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null


--data exploration--
--how many sales--
select count(*) from retail_sales

--how many unique customers?
select  count(distinct customer_id) as total_customers from retail_sales

--how mnay unique categories
select count(distinct category) as total_category from retail_sales
--name of categories
select distinct category from retail_sales


--data analysis--

--write SQL query to retrie all columns for sale made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05'

--SQL query to all transaction where category is 'clothing' and the quantity sold is more than 
--4 in each month of month nov 2022

select * from retail_sales
where
category = 'Clothing' 
and 
quantity >= 4
and 
to_char(sale_date, 'YYYY-MM') = '2022-11'


--query to calculate total sales(total_sale) from each category

select 
category,
sum(total_sale) from retail_sales
group by category 


--SQL query to find average age of customer who purchased items from 'Beauty' category

select ROUND(avg(age),2) as avg_age
from retail_sales 
where category = 'Beauty' 
group by category
 
--SQL query  to find all trasaction where total_sale is greater than 1000

select transaction_id from retail_sales 
where total_sale>1000

-- SQL query to find total no of transaction (transaction_id) made by each gender and each category

select 
category ,
gender,
count(*) as total_trans
from retail_sales
group by 
category , 
gender 
order by 1

--average sale for each month and find out best sellling month in each year

select 
extract(year from sale_date)as year,
extract(month from sale_date) as month,
sum(total_sale) as avg_sale
from retail_sales
group by 1,2
order by 1,2,3 desc


--top 5 customers based on their higest total sales

select distinct(customer_id) ,sum(total_sale) as total_sales 
from retail_sales
group by 1
order by total_sales desc
limit 5;


--SQL query to find number of unique customers who purchased items from each category
select count(distinct customer_id)as uni_customers,
category 
from retail_sales
group by category


--SQL query to create each shift and number of orders \
with hourley_sale
As
(
select *,
	case
	 	when extract(hour from sale_time) < 12  then 'Morming'
		when  extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
		end as shift
 from retail_sales
)
select shift,
count(*) as total_sale
from hourley_sale
group by shift
