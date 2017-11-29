/*aggregation*/
/*min,max,sum,avg,count*/
/*two new clauses*/
/*group by*/
/*Having :test the filter aggregration of value*/
-----------------------------
/*compute the average gpa*/
select avg(GPA)
from Student;
-----------------------------
/*student who've applied to CS major with lowest value*/
select min(GPA)
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
-----------------------------

/*stuednt apply cs multiple times,count same gpa multiple times*/
select avg(GPA)
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/*fix problem*/
selet *
from Student
where sID in (select sID from Apply where major ='CS');
-------------------------------
/*count function*/
select count(*)
from College
where enrollment > 15000;

/*number of application of cornell not student*/
select count(*)
from Apply
where cName = 'Cornell';

/*number of student applied cornell*/
select count(distinct sID)
from Apply
where cName = 'Cornell';
---------------------------------
/*give all student that the number of other students that have same GPA as the student 
is equal to the number of other student taht have the same high school size at the studen*/
select *
from Student S1
where (select count(*) from Student S2
		where S2.sID <> S1.sID and S2.GPA = S1.GPA) = 
	  (select count(*) from Student S2
	  	where S2.sID <> S1.sID and S2.sizeHS = S1.sizeHS);
---------------------------------
/* the amount by which the average GPA of students who apply to CS
exceeds the average GPA of students who donts apply to CS*/

select CS.avgGPA - nonCS.avgGPA
from (select avg(GPA) as avgGPA from Student
		where sID in (
			select sID from Apply where major = "CS")) as CS,
	  (select avg(GPA) as avgGPA from Student
	  	where sID not in (
	  		 select sID from Apply where major = "CS")) as nonCS;

/*duplicate, should add distinct*/
select (select avg(GPA) as avgGPA from Student
		where sID in (
			select sID from Apply where major = 'CS')) - 
		(select avg(GPA) as avgGPA from Student
		 where sID not in (
		 	select sID from Apply where major = "CS")) as d
from Student;
-----------------------------------
/* of applicatns in each college*/
select cName, count(*)
from Apply
group by cName;

select *
from Apply
order by cName;
------------------------------------
select state, sum(enrollment)
from College
group by state;
-----------------------------------
select cName, major, min(GPA), max(GPA)
from Student, Apply
where Student.sID = Apply.sID
order by cName, major;


select cName, major, min(GPA), max(GPA)
from Student, Apply
where Student.sID = Apply.sID
group by cName, major;
-------------------------------------
select mx-mn
from (select cName, major, min(GPA) as mn, max(GPA) mx
from Student, Apply
where Student.sID = Apply.sID
group by cName, major) M;
------------------------------------
select Student.sID, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
order by Student.sID;

select Student.sID, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID;
/*cannot display zero count*/


select Student.sID, sName, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID;



select Student.sID, sName, cName
from Student, Apply
where Student.sID = Apply.sID
order by Student.sID;


select Student.sID, sName,  count(distinct cName), cName
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID;
/*give cName choose a random value of group*/


select Student.sID, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID
union
select sID,0
from Student
where sID not in (select sID from Apply);
/*give student w/o apply any students*/
--------------------------------------
select cName
from Apply
group by cName
having count(*) < 5;
/*keep group count <5*/

select cName
from Apply
group by cName
having count(distinct sID) < 5;
/*keep group count the student in college <5*/



select cName
from Apply A1
where 5 > (select count(*) from Apply A2 where A2.cName = A1.cName);
/*duplicate because for each appliction record many of them is mit
we can add distinct*/
--------------------------------
/*all majors represented in the db where the max GPA of a student 
appliy for that major is lower than the average*/

select major
from Stduent, Apply
where Student.sID = Apply.sID
group by major
having max(GPA) < (select avg(GPA) from Student);

