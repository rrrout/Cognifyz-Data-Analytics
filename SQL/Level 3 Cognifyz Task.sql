CREATE DATABASE Cognifyz;
USE Cognifyz;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 'ON';

Load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Restaurant.csv" into table Restaurant
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- Level 3 
-- Task: Restaurant Reviews 
-- Task i: Analyze the text reviews to identify the most common positive and negative keywords.

SELECT Rating_text,count(Rating_text)
FROM  Restaurant 
GROUP BY Rating_text;

-- Task ii: Calculate the average length of reviews and explore if there is a relationship between review length and rating.

SELECT AVG(LENGTH(Rating_text)) AS AVERAGE_REVIEW_LENGTH
FROM Restaurant;


-- Task 2
-- Task: Votes Analysis 
-- Task i: Identify the restaurants with the highest and lowest number of votes.

SELECT Restaurant_Name, Votes
FROM Restaurant
ORDER BY Votes DESC
LIMIT 1;

SELECT Restaurant_Name, Votes
FROM Restaurant
ORDER BY Votes ASC
LIMIT 1;

-- Task ii: Analyze if there is a correlation between the number of votes and the rating of a restaurant.

Select Average_Cost_for_two  
FROM  Restaurant 
ORDER BY Average_Cost_for_two ASC
LIMIT 1;


-- Task 3
-- Task: Price Range vs. Online Delivery and Table Booking
-- Task i: Analyze if there is a relationship between the price range and the availability of online delivery and table booking.
SELECT Price_range,
	SUM(CASE WHEN Has_Online_delivery = 'Yes' THEN 1 ELSE 0 END) AS ONLNE_DELIVERY_AVAILABLE,
    SUM(CASE WHEN Has_Table_booking = 'Yes' THEN 1 ELSE 0 END) AS TABLE_BOOKING_AVAILABLE,
    COUNT(*) AS TOTAL_RESTAURANTS
    FROM Restaurant
    GROUP BY Price_range;

-- Task ii: Determine if higher-priced restaurants are more likely to offer these services.

SELECT Price_range, AVG(Average_Cost_for_two) AS COST_OF_RESTAURANTS,
	SUM(CASE WHEN Has_Online_delivery = 'Yes' THEN 1 ELSE 0 END) AS ONLNE_DELIVERY_AVAILABLE,
    SUM(CASE WHEN Has_Table_booking = 'Yes' THEN 1 ELSE 0 END) AS TABLE_BOOKING_AVAILABLE,
    COUNT(*) AS TOTAL_RESTAURANTS
    FROM Restaurant
    GROUP BY Price_range;
