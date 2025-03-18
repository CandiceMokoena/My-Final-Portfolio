SELECT*
	FROM supermarket_sales.sales;
    
    -- REPLICATE RAW DATA TABLE --
    CREATE TABLE supermarket_sales.sales2
		LIKE supermarket_sales.sales;
	
    INSERT into sales2
		SELECT*
			FROM supermarket_sales.sales;

SELECT*
	FROM sales2;
    
-- DATA CLEANING --

-- 1. REMOVE DUPLICATES --
WITH Duplicate_CTE AS (
	SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY Branch, `Customer type`, Gender, `Product line`, Quantity
            ORDER BY 'Date'
		) AS row_num
	FROM sales2
)
SELECT*
	FROM Duplicate_CTE WHERE row_num > 1;

-- STANDARDIZING THE DATA --

SELECT DISTINCT Payment
	FROM sales2;
    
-- SALES PERFORMANCE, PROFITABILITY AND TRENDS ANALYSIS--

-- Total revenue--
SELECT SUM(Total) AS total_revenue
 FROM sales2;
 
-- Total Quantity sold--
SELECT SUM(Quantity) AS total_quantity 
FROM sales2;

-- Total cost of goods sold--
SELECT SUM(cogs) AS total_cogs 
FROM sales2;

-- Sales per day--
SELECT Date, SUM(Total) AS daily_sales 
FROM sales2 
GROUP BY Date 
ORDER BY Date;

--Sales by time of day--
SELECT Time, SUM(Total) AS sales_by_time  
FROM sales2
GROUP BY Time  
ORDER BY sales_by_time DESC;  





    
	