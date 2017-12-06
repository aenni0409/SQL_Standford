--Add the reviewer Roger Ebert to your database, 
--with an rID of 209.
INSERT INTO Reviewer (rID,name)
VALUES (209,'Roger Ebert');

--Insert 5-star ratings by James Cameron for all 
--movies in the database. Leave the review date as NULL. 
INSERT INTO Rating 
	SELECT Rating.rID, Movie.mID, 5 as stars, null as ratingDate
	FROM Rating, Movie, Reviewer
	WHERE Rating.rID = Reviewer.rID
	AND Reviewer.name = 'James Cameron';

--For all movies that have an average rating of 4 stars or 
--higher, add 25 to the release year. (Update the existing 
--tuples; don't insert new tuples.) 

Update Movie
SET year = year + 25
WHERE mID IN (
  SELECT Movie.mId
  FROM Movie, Rating
  WHERE Movie.mID = Rating.mID
  GROUP BY Movie.mID
  HAVING avg(stars) >= 4
);

--Remove all ratings where the movie's year is before 1970 
--or after 2000, and the rating is fewer than 4 stars. 
DELETE FROM Rating
WHERE Rating.mID IN (SELECT DISTINCT mID FROM Movie WHERE year < 1970 OR year > 2000)
AND Rating.stars < 4;