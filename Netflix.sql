-- NETFLIX DATA ANALYSIS --

CREATE DATABASE Netflix;
USE Netflix;

CREATE TABLE Genre_Details (
Genre_ID VARCHAR(10) PRIMARY KEY,
Genre VARCHAR(50)
);


CREATE TABLE Netflix_Originals (
ID INT PRIMARY KEY AUTO_INCREMENT,
Title VARCHAR(50),
Genre_ID VARCHAR(10),
Runtime INT,
IMDB_Score DECIMAL(3,1),
Language VARCHAR(50),
Premiere_Date DATE,
FOREIGN KEY (Genre_ID) REFERENCES Genre_Details (Genre_ID)
);

SELECT * FROM Netflix_Originals;

-- IMPORT DATASET USING SQL WORKBENCH --

-- 1-> What are the average IMDb scores for each genre of Netflix Originals? --

SELECT Genre_Details.Genre, AVG(Netflix_Originals.IMDB_Score) AS Avg_IMDB_Score
FROM Netflix_Originals
JOIN Genre_Details ON Netflix_Originals.Genre_ID = Genre_Details.Genre_ID
GROUP BY Genre_Details.Genre;


-- 2-> Which genres have an average IMDb score higher than 7.5? --

SELECT Genre_Details.Genre, AVG(Netflix_Originals.IMDB_Score) AS Avg_IMDB_Score
FROM Netflix_Originals
JOIN Genre_Details ON Netflix_Originals.Genre_ID = Genre_Details.Genre_ID
GROUP BY Genre_Details.Genre
HAVING Avg_IMDB_Score > 7.5;


-- 3->  List Netflix Original titles in descending order of their IMDb scores. --

SELECT Title, IMDB_Score
FROM Netflix_Originals
ORDER BY IMDB_Score DESC;


-- 4->  Retrieve the top 10 longest Netflix Originals by runtime. --

SELECT Title, Runtime
FROM Netflix_Originals
ORDER BY Runtime DESC
LIMIT 10;


-- 5-> Retrieve the titles of Netflix Originals along with their respective genres. --

SELECT Netflix_Originals.Title, Genre_Details.Genre
FROM Netflix_Originals
JOIN Genre_Details ON Netflix_Originals.Genre_ID = Genre_Details.Genre_ID;


-- 6-> Rank Netflix Originals based on their IMDb scores within each genre. --

SELECT Netflix_Originals.Title, Genre_Details.Genre, Netflix_Originals.IMDB_Score,
RANK() OVER (PARTITION BY Genre_Details.genre ORDER BY Netflix_Originals.IMDB_Score DESC) AS Rank_Within_Genre
FROM Netflix_Originals
JOIN Genre_Details ON Netflix_Originals.Genre_ID = Genre_Details.Genre_ID;


-- 7-> Which Netflix Originals have IMDb scores higher than the average IMDb score of all titles? --

SELECT Title, IMDB_Score
FROM Netflix_Originals
WHERE IMDB_Score > (SELECT AVG(IMDB_Score) FROM Netflix_Originals);


-- 8-> How many Netflix Originals are there in each genre? --

SELECT Genre_Details.Genre, COUNT(Netflix_Originals.Title) AS Number_Of_Titles
FROM Netflix_Originals
JOIN Genre_Details ON Netflix_Originals.Genre_Id = Genre_Details.Genre_ID
GROUP BY Genre_Details.Genre;


-- 9-> Which genres have more than 5 Netflix Originals with an IMDb score higher than 8? --

SELECT Genre_Details.Genre, COUNT(Netflix_Originals.Title) AS HIgh_IMDB_Rated
FROM Netflix_Originals
JOIN Genre_Details ON Netflix_Originals.Genre_ID = Genre_Details.Genre_ID
WHERE Netflix_Originals.IMDB_Score > 8
GROUP BY Genre_Details.Genre
HAVING High_IMDB_Rated;


-- 10-> What are the top 3 genres with the highest average IMDb scores, and how many Netflix Originals do they have? --

SELECT Genre_Details.Genre, 
AVG(Netflix_Originals.IMDB_Score) AS Avg_IMDB_Score,
COUNT(Netflix_Originals.Title) AS Number_Of_Titles
FROM Netflix_Originals
JOIN Genre_Details ON Netflix_Originals.Genre_ID = Genre_Details.Genre_ID
GROUP BY Genre_Details.Genre
ORDER BY Avg_IMDB_Score DESC
LIMIT 3;



-- PROJECT COMPLETE --