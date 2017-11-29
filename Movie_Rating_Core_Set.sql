/*Find the titles of all movies directed by Steven Spielberg.*/
SELECT M.title
FROM Movie M
WHERE M.director = 'Steven Spielberg';

/*Find all years that have a movie that received a rating of 
4 or 5, and sort them in increasing order. */

SELECT DISTINCT M.year
FROM Movie M, Rating R
WHERE R.stars IN (4,5)
AND M.mID = R.mID
ORDER BY M.year ASC;

/*Find the titles of all movies that have no ratings.*/

SELECT DISTINCT IFNULL(M.title,R.stars)
FROM Movie M, Rating R
WHERE M.mID = R.mID;



/*Some reviewers didn't provide a date with their rating. 
Find the names of all reviewers who have ratings with a 
NULL value for the date. */

SELECT DISTINCT IFNULL(Re.name,R.ratingDate)
FROM Reviewer Re, Rating R
WHERE Re.rID = R.rID;

/*Write a query to return the ratings data in a more readable 
format: reviewer name, movie title, stars, and ratingDate. 
Also, sort the data, first by reviewer name, then by movie 
title, and lastly by number of stars. */

SELECT Re.name, M.title, R.stars, R.ratingDate
FROM Rating R, Reviewer Re, Movie M
WHERE R.rID = Re.rID
AND R.mID = M.mID
ORDER BY Re.name, M.title, R.ratingDate;

/*For all cases where the same reviewer rated the same movie 
twice and gave it a higher rating the second time, return the 
reviewer's name and the title of the movie. */

SELECT Distinct Re.name, M.title
FROM (SELECT R1.rID, R1.mID
	  FROM Rating R1, Rating R2
	  WHERE R1.rID = R2.rID
	  AND R1.mID = R2.mID
	  AND R1.stars > R2.stars
	  AND R1.ratingDate > R2.ratingDate) Rating_new, 
      Reviewer Re,
      Movie M

WHERE Re.rID = Rating_new.rID
AND Rating_new.mID = M.mID;

/*For each movie that has at least one rating, 
find the highest number of stars that movie received. 
Return the movie title and number of stars. 
Sort by movie title. */

SELECT M.title, R_new.max_stars
FROM (SELECT R.mID, MAX(R.stars) max_stars
		FROM Rating R
		GROUP BY R.mID) R_new, Movie M
WHERE M.mID = R_new.mID
ORDER BY M.title;


/*List movie titles and average ratings, 
from highest-rated to lowest-rated. 
If two or more movies have the same average rating, 
list them in alphabetical order. */
SELECT M.title, avg_rating.avg_stars
FROM Movie M,
	 (SELECT mID, AVG(R.stars) avg_stars
	  FROM Rating R
	  GROUP BY mID) avg_rating
WHERE M.mID = avg_rating.mID
ORDER BY avg_rating.avg_stars DESC, M.title;

/*Find the names of all reviewers who have contributed 
three or more ratings. (As an extra challenge, try writing 
the query without HAVING or without COUNT.) */

SELECT DISTINCT Re.name
FROM Reviewer Re,(
SELECT R.rID
FROM Rating R
GROUP BY R.rID
HAVING COUNT(R.rID) >2) Rating_new
WHERE Re.rID = Rating_new.rID;








