-- Start by getting a feel for the hacker_news table! What are the top five stories with the highest scores?
SELECT title, score
FROM hacker_news
ORDER BY score DESC
LIMIT 5;

-- Is a small percentage of Hacker News submitters taking the majority of the points? First, find the total score of all the stories.
SELECT SUM(score)
FROM hacker_news;

--Find the individual users who have gotten combined scores of more than 200, and their combined scores.
SELECT user, score
FROM hacker_news
GROUP BY 1
HAVING SUM(score) > 200
ORDER BY 2 DESC;


--Then, we want to add these users’ scores together and divide by the total to get the percentage. Add their scores together and divide it by the total sum.
SELECT (517 + 309 + 304 + 282) / 6366.0;

-- Which of these sites feed Hacker News the most: GitHub, Medium, or New York Times? First, we want to categorize each story based on their source.
/*
SELECT 
  CASE
    WHEN url LIKE '%github%' THEN 'Github'
    WHEN url LIKE '%medium%' THEN 'Medium'
    WHEN url LIKE '%nytimes%' THEN 'New York Times'
    ELSE 'Other'
  END AS 'Source'
FROM hacker_news;
*/

--Add a column for the number of stories from each URL using COUNT().
SELECT 
  CASE
    WHEN url LIKE '%github%' THEN 'Github'
    WHEN url LIKE '%medium%' THEN 'Medium'
    WHEN url LIKE '%nytimes%' THEN 'New York Times'
    ELSE 'Other'
  END AS 'Source',
  COUNT(*)
FROM hacker_news
GROUP BY 1;

-- What’s the best time of the day to post a story on Hacker News?
SELECT timestamp, SUM(score)
FROM hacker_news
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Let’s write a query that returns three columns: The hours of the timestamp, the average score for each hour, and the count of stories for each hour
SELECT 
  strftime('%H', timestamp) AS 'Hour', 
  ROUND(AVG(score), 2) AS 'Average Score', 
  COUNT(*) AS 'Number of Stories'
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 1;
