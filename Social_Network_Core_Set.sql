--Find the names of all students who are friends with 
--someone named Gabriel.

SELECT name
FROM Highschooler H,
	(SELECT F.ID2
	FROM Friend F, Highschooler H
	WHERE F.ID1 = H.ID
	AND H.name = 'Gabriel') t1
WHERE H.ID = t1.ID2;

--For every student who likes someone 2 or more grades 
--younger than themselves, return that student's name 
--and grade, and the name and grade of the student they 
--like. 

SELECT H1.name name1, H1.grade grade1, H2.name name2, H2.grade grade2
FROM Highschooler H1, Highschooler H2, Likes L
WHERE L.ID1 = H1.ID
AND L.ID2 = H2.ID
AND grade1 - grade2 >=2;

--For every pair of students who both like each other, 
--return the name and grade of both students. Include 
--each pair only once, with the two names in alphabetical 
--order. 

SELECT H1.name n1, H1.grade, H2.name n2, H2.grade
FROM Highschooler H1, Highschooler H2,
	(SELECT L1.ID1, L1.ID2
	FROM Likes L1, Likes L2
	WHERE L1.ID1 = L2.ID2
	AND L1.ID2 = L2.ID1) t1
WHERE H1.ID = t1.ID1
AND H2.ID = t1.ID2
AND n1 < n2;

--Find names and grades of students who only have friends 
--in the same grade. Return the result sorted by grade, 
--then by name within each grade. 
SELECT H.name, H.grade
FROM Highschooler H,
	 (SELECT ID1 
	FROM Friend F
	EXCEPT
	SELECT ID1 
	FROM Friend F, Highschooler H1, Highschooler H2
	WHERE F.ID1 = H1.ID
	AND F.ID2 = H2.ID
	AND H1.grade <> H2.grade) t1
WHERE H.ID = t1.ID1
ORDER BY grade, name;

--Find the name and grade of all students who are liked 
--by more than one other student. 

SELECT H.grade, H.name
FROM Highschooler H, Likes L
WHERE H.ID = L.ID2
GROUP BY L.ID2
HAVING COUNT(L.ID1) >1 ;






