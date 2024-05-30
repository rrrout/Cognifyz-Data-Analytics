CREATE DATABASE Cognifyz;

USE Cognifyz;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 'ON';

Load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Restaurant.csv" into table Restaurant
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


-- Level 1
-- Task: Top Cuisines 

-- Task i: Determine the top three most common cuisines in the dataset. 
SELECT Cuisines, Votes 
FROM Restaurant 
ORDER BY Votes DESC LIMIT 3;


-- Task ii: Calculate the percentage of restaurants that serve each of the top cuisines. 
SELECT ( (Total_Number_Of_Restaurant_Serving_Top_Cuisines * 100) / (SELECT COUNT(DISTINCT Restaurant_Name) AS Total_Number_Of_Restaurant  FROM  Restaurant )) AS PERCENTAGE_OF_RESTAURANT
 FROM (
SELECT COUNT(DISTINCT Restaurant_Name) AS Total_Number_Of_Restaurant_Serving_Top_Cuisines  FROM  Restaurant 
WHERE Cuisines IN ("Italian","American","Pizza","Burger","Cafe","Continental","Asian","North Indian")
) AS PERCENTAGE_SUBQUERY ;



-- *****************************************************************************************************************************************************************************

-- Task 2 
-- Task: City Analysis 
-- Task i: Identify the city with the highest number of restaurants in the dataset.

SELECT  City AS CITY_NAME_WITH_HIGHEST_NUMBER_OF_RESTAURANT , COUNT(City) AS NUMBER_OF_RESTAURANT_IN_EACH_CITY 
FROM Restaurant 
GROUP BY City 
ORDER BY NUMBER_OF_RESTAURANT_IN_EACH_CITY DESC
LIMIT 1;

-- Task ii: Calculate the average rating for restaurants in each city.

SELECT  City, AVG(Aggregate_rating) AS AVERAGE_RATING_OF_RESTAURANT_IN_EACH_CITY
FROM Restaurant 
WHERE Aggregate_rating IS NOT NULL
GROUP BY City 
ORDER BY AVERAGE_RATING_OF_RESTAURANT_IN_EACH_CITY DESC;


-- Task iii: Determine the city with the highest average rating.

SELECT  City, AVG(Aggregate_rating) AS AVERAGE_RATING_OF_RESTAURANT_IN_EACH_CITY
FROM Restaurant 
WHERE Aggregate_rating IS NOT NULL
GROUP BY City 
ORDER BY AVERAGE_RATING_OF_RESTAURANT_IN_EACH_CITY DESC
LIMIT 1;

-- *****************************************************************************************************************************************************************************

-- Task 3 
-- Task: Price Range Distribution
-- Task i: Create a histogram or bar chart to visualize the distribution of price ranges among the restaurants.
 
 Select Price_range,Currency,Restaurant_Name  
 FROM  Restaurant ;

Select Price_range, COUNT(Price_range) AS NUMBER_OF_RESTAURANT_AVAILABLE_IN_THIS_PRICE_RANGE  
FROM  Restaurant GROUP BY Price_range;

-- Task ii: Calculate the percentage of restaurants in each price range category.

SELECT PRICE_RANGE_CATEGORY,NUMBER_OF_RESTAURANT_AVAILABLE_IN_THIS_PRICE_RANGE, 
( 
	(NUMBER_OF_RESTAURANT_AVAILABLE_IN_THIS_PRICE_RANGE * 100) 
	/ 
	(SELECT COUNT(Restaurant_Name) AS Total_Number_Of_Restaurant  FROM  Restaurant WHERE Price_range IS NOT NULL )
) AS PERCENTAGE_OF_RESTAURANT_IN_EACH_PROCE_RANGE_CATEGORY
FROM (
Select Price_range AS PRICE_RANGE_CATEGORY,COUNT(Price_range) AS NUMBER_OF_RESTAURANT_AVAILABLE_IN_THIS_PRICE_RANGE  
FROM  Restaurant 
WHERE Price_range IS NOT NULL
GROUP BY Price_range
) AS PERCENTAGE_OF_RESTAURANT_IN_EACH_PRICE_CATEGORY;


Select COUNT(Price_range) AS NUMBER_OF_RESTAURANT_AVAILABLE_IN_THIS_PRICE_RANGE  FROM  Restaurant GROUP BY Price_range;

-- Task 4
-- Task : Online Delivery
-- Task i: Determine the percentage of restaurants that offer online delivery.

SELECT ( (NUMBER_OF_RESTAURANT_OFFERING_ONLINE_DELIVERY * 100) / (SELECT COUNT(Restaurant_Name) AS Total_Number_Of_Restaurant  FROM  Restaurant )) AS PERCENTAGE_OF_RESTAURANT_OFFERING_ONLINE_DELIVERY
 FROM (
Select COUNT(DISTINCT Restaurant_Name) AS NUMBER_OF_RESTAURANT_OFFERING_ONLINE_DELIVERY  FROM  Restaurant WHERE Has_Online_delivery = "Yes"
) AS ONLINE_DELIVERY_PERCENTAGE;


-- Task ii: Compare the average ratings of restaurants with and without online delivery.

		SELECT AVG(Aggregate_rating) AS AVERAGE_RATING_OF_RESTAURANT_WITH_ONLINE_DELIVERY, COUNT(Has_Online_delivery)
         FROM Restaurant 
		 GROUP BY Has_Online_delivery
		HAVING Has_Online_delivery = "Yes"
        
        UNION ALL
        
        SELECT AVG(Aggregate_rating) AS AVERAGE_RATING_OF_RESTAURANT_WITH_OFFLINE_DELIVERY, COUNT(Has_Online_delivery)
         FROM Restaurant 
		 GROUP BY Has_Online_delivery
		HAVING Has_Online_delivery = "No";
        
	-- Another way
   SELECT
  CASE Has_Online_delivery
    WHEN 'Yes' THEN 'With Online Delivery'
    WHEN 'No' THEN 'Without Online Delivery'
  END AS Delivery_Status,
  AVG(Aggregate_rating) AS Average_Rating
FROM Restaurant
GROUP BY Has_Online_delivery;

