SELECT * FROM exercise_db.sample_superstore_complete_csve
WHERE `Order date` = '2017-01-04';
-- Lists the Daily Customers, Products Sold, Total Profit and Average Revenue Per Customer(ARPC)
WITH CTE1 AS (SELECT `order date`, COUNT(DISTINCT`customer id`) AS no_of_customer_each_day FROM sample_superstore_complete_csve
			  GROUP BY `order date`),
     CTE2 AS (SELECT `order date`,SUM(quantity) as total_quantity_sold_daily FROM sample_superstore_complete_csve
              GROUP BY `order date`),
     CTE3 AS (SELECT `order date`,ROUND(SUM(profit),2)as total_daily_profit FROM sample_superstore_complete_csve
              GROUP BY `order date`),
     CTE4 AS (SELECT  `order date`, ROUND(SUM(sales)/COUNT(DISTINCT`customer id`),2) AS ARPC from sample_superstore_complete_csve
			  GROUP BY  `order date`)
SELECT CTE1.`order date`, no_of_customer_each_day,total_quantity_sold_daily,total_daily_profit,ARPC
FROM CTE1 JOIN CTE2 ON CTE1.`order date` = CTE2.`order date`
		  JOIN CTE3 ON CTE1.`order date` = CTE3.`order date`
          JOIN CTE4 ON CTE1.`order date` =  CTE4.`order date`;
          
-- Lists the Monthly Customers, Products Sold, Total Profit and Average Revenue Per Customer
WITH Ayo AS (SELECT DATE_FORMAT(`order date`,'%Y-%m') AS m, COUNT(DISTINCT `customer id`) as no_of_customers 
             FROM sample_superstore_complete_csve
             GROUP BY 1),
     Bayo AS (SELECT  DATE_FORMAT(`order date`,'%Y-%m')as m,SUM(Quantity) as product_sold FROM sample_superstore_complete_csve
              GROUP BY 1),
     Dayo AS (SELECT DATE_FORMAT(`order date`,'%Y-%m')as m, ROUND(SUM(profit),2) AS total_PROFIT FROM sample_superstore_complete_csve
              GROUP BY 1),
	 Sayo AS (SELECT DATE_FORMAT(`order date`,'%Y-%m') AS m,ROUND(SUM(sales)/COUNT(DISTINCT `customer id`),2) as AVRPC FROM sample_superstore_complete_csve
              GROUP BY 1)
SELECT Ayo.m,no_of_customers,product_sold,total_profit,AVRPC 
FROM Ayo JOIN Bayo ON Ayo.m = Bayo.m
         JOIN Dayo ON Ayo.m = Dayo.m
         JOIN Sayo ON Ayo.m = Sayo.m
ORDER BY m;

-- Lists the Yearly Customers, Products Sold, Total Profit and Average Revenue Per Customer

WITH CTE1 AS (SELECT YEAR(`order date`) AS order_year, COUNT(DISTINCT`customer id`) AS no_of_customer_each_year FROM sample_superstore_complete_csve
		      GROUP BY 1),
CTE2 AS      (SELECT YEAR(`order date`) AS order_year,SUM(quantity) as total_quantity_sold_yearly FROM sample_superstore_complete_csve
              GROUP BY 1),
CTE3 AS      (SELECT YEAR(`order date`)as order_year, ROUND(SUM(profit),2) AS total_PROFIT FROM sample_superstore_complete_csve
              GROUP BY 1),
CTE4 AS      (SELECT YEAR(`order date`) AS order_year,ROUND(SUM(sales)/COUNT(DISTINCT `customer id`),2) as AVRPC FROM sample_superstore_complete_csve
              GROUP BY 1)
SELECT CTE1.order_year, no_of_customer_each_year,total_quantity_sold_yearly,total_PROFIT,AVRPC 
FROM CTE1 JOIN CTE2 ON CTE1.order_year = CTE2.order_year
          JOIN CTE3 ON CTE1.order_year = CTE3.order_year
          JOIN CTE4 ON CTE1.order_year = CTE4.order_year
