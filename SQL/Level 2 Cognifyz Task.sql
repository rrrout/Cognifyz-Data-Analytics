CREATE DATABASE Cognifyz;

USE Cognifyz;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 'ON';

Load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Restaurant.csv" into table Restaurant
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


-- Level 2 
-- Task : Restaurant Ratings
-- Task i: Analyze the distribution of aggregate ratings and determine the most common rating range.

SELECT AGGREGATE_RATING_CATEGORY,NUMBER_OF_RESTAURANT_WITH_EACH_RATING_CATEGORY, ( (NUMBER_OF_RESTAURANT_WITH_EACH_RATING_CATEGORY * 100) / (SELECT COUNT(DISTINCT Restaurant_Name) AS TOTAL_NUMBER_OF_RESTAURANT  FROM  Restaurant )) AS PERCENTAGE_OF_RESTAURANT_IN_EACH_RATING_CATEGORY
 FROM (
Select Aggregate_rating AS AGGREGATE_RATING_CATEGORY, COUNT(Aggregate_rating) AS NUMBER_OF_RESTAURANT_WITH_EACH_RATING_CATEGORY  FROM  Restaurant GROUP BY Aggregate_rating
) AS EACH_RATING_CATEGORY
ORDER BY PERCENTAGE_OF_RESTAURANT_IN_EACH_RATING_CATEGORY DESC
LIMIT 2;


-- Task ii: Calculate the average number of votes received by restaurants.

SELECT AVG(Votes) AS AVERAGE_VOTES_PER_RESTAURANT
FROM Restaurant;

SELECT COUNT(Restaurant_Name) 
FROM Restaurant;

-- Task 2	
-- Task : Cuisine Combination
-- Task i: Identify the most common combinations of cuisines in the dataset.
SELECT Cuisines, Votes, Aggregate_rating
FROM Restaurant 
ORDER BY Votes DESC LIMIT 5;

-- Task ii: Determine if certain cuisine combinations tend to have higher ratings.
SELECT Cuisines, Aggregate_rating
FROM Restaurant 
ORDER BY Aggregate_rating DESC LIMIT 5;

-- Task 4
-- Task: Restaurant Chains 
-- Task i: Identify if there are any restaurant chains present in the dataset.

SELECT Restaurant_Name FROM Restaurant
GROUP BY Restaurant_Name
HAVING COUNT(Restaurant_Name) > 1;

-- Task ii: Analyze the ratings and popularity of different restaurant chains.

SELECT Restaurant_Name,
  AVG(Aggregate_rating) AS Average_rating,
  SUM(Votes) AS Total_Votes,
  COUNT(DISTINCT Locality) AS Number_of_Location
FROM ANALYZE_RATINGS_AND_POPULARITY
GROUP BY Restaurant_Name
ORDER BY Total_Votes DESC;
