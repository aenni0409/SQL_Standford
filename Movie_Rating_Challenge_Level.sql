--For each movie, return the title and the 'rating spread', 
--that is, the difference between highest and lowest ratings 
--given to that movie. Sort by rating spread from highest to 
--lowest, then by movie title. 

SELECT DISTINCT M.title, Rating_new.rating_spread
FROM Movie M,(SELECT mID, MAX(stars)-MIN(stars) rating_spread
			FROM Rating R
			GROUP BY mID) Rating_new
WHERE M.mID = Rating_new.mID
ORDER BY Rating_new.rating_spread DESC, M.title;

--Find the difference between the average rating of movies 
--released before 1980 and the average rating of movies released 
--after 1980. (Make sure to calculate the average rating for each 
--movie, then the average of those averages for movies before 1980 
--and movies after. Don't just calculate the overall average 
--rating before and after 1980.) 


SELECT (A.avg_before-B.avg_after)
FROM  (SELECT AVG(A.avg_star) avg_before
	  FROM( SELECT M.mID, M.year, Rating_new.avg_star
	  		FROM Movie M
			JOIN (SELECT R.mID, avg(R.stars) avg_star
	  				FROM Rating R 
	  				GROUP BY R.mID) Rating_new ON M.mID = Rating_new.mID
			WHERE M.year <= 1980) A ) A,

		(SELECT AVG(B.avg_star) avg_after
			  FROM( SELECT M.mID, M.year, Rating_new.avg_star
			  		FROM Movie M
					JOIN (SELECT R.mID, avg(R.stars) avg_star
			  				FROM Rating R 
			  				GROUP BY R.mID) Rating_new ON M.mID = Rating_new.mID
					WHERE M.year > 1980) B) B;

--Some directors directed more than one movie. 
--For all such directors, return the titles of all movies directed 
--by them, along with the director name. Sort by director name, 
--then movie title. (As an extra challenge, try writing the query 
--both with and without COUNT.) 

--w/ COUNT
SELECT M.title, M.director
FROM Movie M, 
	 (SELECT M.director
	 FROM Movie M
	 GROUP BY M.director
	 HAVING COUNT(M.title)>=2) direc
WHERE M.director = direc.director
ORDER BY M.director, M.title;

--w/o COUNT
select M1.title, M1.director
from Movie M1, Movie M2
where M1.director = M2.director and M1.title <> M2.title
order by M1.director, M1.title;

--Find the movie(s) with the highest average rating. 
--Return the movie title(s) and average rating. 
--(Hint: This query is more difficult to write in SQLite 
--than other systems; you might think of it as finding 
--the highest average rating and then choosing the movie(s) 
--with that average rating.) 

--Method 1:
SELECT M.title, r_new_1.avg_rating
FROM Movie M,
	(SELECT mID, avg(stars) avg_rating
	FROM Rating
	GROUP BY mID
	) r_new_1,
	(SELECT MAX(avg_rating) max_rating
	FROM (SELECT AVG(stars) avg_rating
			FROM Rating
			GROUP BY mID)
	) r_new_2
WHERE M.mID = r_new_1.mID
AND r_new_1.avg_rating = r_new_2.max_rating;

--Find the movie(s) with the lowest average rating. Return the 
--movie title(s) and average rating. (Hint: This query may be more 
--difficult to write in SQLite than other systems; you might think 
--of it as finding the lowest average rating and then choosing the 
--movie(s) with that average rating.)

SELECT M.title, r_new_1.avg_rating
FROM Movie M,
	(SELECT mID, avg(stars) avg_rating
	FROM Rating
	GROUP BY mID
	) r_new_1,
	(SELECT MIN(avg_rating) min_rating
	FROM (SELECT AVG(stars) avg_rating
			FROM Rating
			GROUP BY mID)
	) r_new_2
WHERE M.mID = r_new_1.mID
AND r_new_1.avg_rating = r_new_2.min_rating;

--For each director, return the director's name together with the 
--title(s) of the movie(s) they directed that received the highest 
--rating among all of their movies, and the value of that rating. 
--Ignore movies whose director is NULL. 

SELECT DISTINCT t1.director, t1.title, t1.stars
FROM (SELECT M.director, M.title, R.stars
		FROM Movie M, Rating R
		WHERE M.mID = R.mID
		AND M.director IS NOT NULL
		) t1,
	  (SELECT director, max(stars) as max_star
		FROM Movie, Rating
		WHERE Movie.mID = Rating.mID
		AND director IS NOT NULL
		GROUP BY director
	  ) t2
WHERE t1.director = t2.director
AND t1.stars = t2.max_star;
		
SELECT DISTINCT mov1.director, mov1.title, rat1.stars
FROM movie AS mov1, rating AS rat1
WHERE mov1.mid = rat1.mid
AND mov1.director IS NOT NULL
AND rat1.stars IN
(
    SELECT MAX(rat2.stars)
    FROM movie AS mov2, rating AS rat2
    WHERE mov2.mid = rat2.mid
    AND mov2.director IS NOT NULL
    AND mov2.director = mov1.director
);

