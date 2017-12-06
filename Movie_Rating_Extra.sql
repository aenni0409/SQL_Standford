--Find the names of all reviewers who rated Gone with the Wind. 
SELECT DISTINCT Re.name
FROM Reviewer Re, Rating Ra, Movie M
WHERE Re.rID = Ra.rID
AND Ra.mID = M.mID
AND M.title = "Gone with the Wind";

SELECT DISTINCT t1.name
FROM 	(SELECT Ra.mID, Re.name
	  	FROM Rating Ra
	  	JOIN Reviewer Re ON Re.rID = Ra.rID
		) t1
JOIN 	(SELECT * FROM Movie) M ON t1.mID = M.mID
WHERE M.title = "Gone with the Wind";

--For any rating where the reviewer is the same as the director 
--of the movie, return the reviewer name, movie title, and number 
--of stars.

SELECT Re_name, title, stars
FROM (SELECT Ra.mID, Ra.stars, Re.name Re_name
		FROM Rating Ra
		JOIN Reviewer Re ON Ra.rID = Re.rID) t1
JOIN (SELECT M.mID, M.title, M.director M_name
		FROM Movie M
		) t2 ON t1.mID = t2.mID
WHERE t1.Re_name = t2.M_name;

--Return all reviewer names and movie names together in a single 
--list, alphabetized. (Sorting by the first name of the reviewer 
--and first word in the title is fine; no need for special processing 
--on last names or removing "The".) 

SELECT name
FROM (SELECT DISTINCT Re.name name FROM Reviewer Re
	  UNION
	  SELECT DISTINCT M.title name FROM Movie M)
order by name ;

--Find the titles of all movies not reviewed by Chris Jackson. 

SELECT DISTINCT M.title
FROM Movie M
WHERE M.mID NOT IN  (SELECT Ra.mID
	FROM Rating Ra
	JOIN Reviewer Re ON Re.rID = Ra.rID
	WHERE Re.name = "Chris Jackson") ;



select distinct title
from Movie
except
select distinct title
from Reviewer, Movie, Rating
where Reviewer.rID = Rating.rID 
and Rating.mID = Movie.mID
and name = 'Chris Jackson';

--For all pairs of reviewers such that both reviewers gave a rating 
--to the same movie, return the names of both reviewers. Eliminate 
--duplicates, don't pair reviewers with themselves, and include each 
--pair only once. For each pair, return the names in the pair in 
--alphabetical order. 

SELECT DISTINCT name1, name2
FROM(SELECT R1.rID, Re1.name name1, R2.rId, Re2.name name2, R1.mID
		FROM Rating R1, Rating R2, Reviewer Re1, Reviewer Re2
		WHERE R1.mID = R2.mID
		AND R1.rID <> R2.rID
		AND R1.rID = Re1.rID
		AND R2.rID = Re2.rID)
WHERE name1 < name2
ORDER By name1, name2;


--For each rating that is the lowest (fewest stars) currently in 
--the database, return the reviewer name, movie title, and 
--number of stars. 

SELECT Re.name, M.title,  R.stars
FROM Movie M, Reviewer Re, Rating R
WHERE M.mID = R.mID
AND R.rID = Re.rID
AND R.stars IN (SELECT DISTINCT MIN(stars) FROM Rating)
ORDER BY M.title, Re.name;
















