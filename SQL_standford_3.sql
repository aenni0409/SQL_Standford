/*Subqueries in FROM and SELECT*/
select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student
where GPA*(sizeHS/1000.0) -GPA > 1.0
or GPA - GPA*(sizeHS/1000.0) < 1.0;

select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student
where abs( GPA*(sizeHS/1000.0) -GPA ) > 1.0;

select *
from (select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student) G 
where  abs(G.scaledGPA - GPA) > 1.0;
--------------------------------------------
/*find college with highest gpa among application*/
/*there is error*/
select College.cName, state, GPA
from College, Apply, Student
where College.cName = Apply.cName
	and Apply.sID = Student.sID
	and GPA >= 
			(select GPA from Student, Apply, College
			 where Student.sID = Apply.sID
			 and Apply.cName = College.cName);


select distinct College.cName, state, GPA
from College, Apply, Student
where College.cName = Apply.cName
	and Apply.sID = Student.sID
	and GPA >= all
			(select GPA from Student, Apply
			 where Student.sID = Apply.sID
			 	and Apply.cName = College.cName);			
------------------------------------------------
/*for each college to find highest gpa */
select cName, state, 
(select distinct GPA from Apply, Student)
from Apply, Student
where College.cName = Apply.cName 
	and Apply.sID = Student.sID
	and GPA >=  all
				(select GPA from Student, Apply
					where Student.sID = Apply.sID
						and Apply.cName = College.cName)) as GPA
from College;
------------------------------------------------
/*pair every college with highest of applicant(name)*/
/* subquery need to term exact one value*/
/*error included*/
select cName, state, 
(select distinct sName
from Apply, Student
where College.cName = Apply.cName 
	and Student.sID = Apply.sID) as sName
from College;

select distinct College.cName, state, Student.sID, GPA
from College, Apply, Student
where College.cName = Apply.cName;

