/*Subqueries in FROM and SELECT*/
/*include subqueries*/
select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
/*select sID, sName where sID in the sID of Apply with major cs*/

select Student.sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
/*addition duplication, amy apply multiple cs cName so duplicate*/

select distinct Student.sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
/*same result as subquery*/
------------------------------------------------
select sName
from Student
where sID in (select sID from Apply where major ='CS');

select sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

select distinct sName
from Student, Apply
where Student.sID = APply.sID and major = 'CS';
/*different from section  1 cause same name with differ sID*/

select GPA
from Student
where sID in (select sID from Apply where major ="CS");

select GPA 
from Student, Apply
where Student.sID = Apply.sID and major = "CS";
/*might count student multiple times*/
/*cannot use distinct cause some students have same GPA*/
------------------------------------------------
selet sID, sName
from Studentwhere 
where sID in (select sID from Apply where major = "CS")
	and sID not in (select sID from Apply where major ="EE");
/*student applied CS but not EE*/

select sName, state
from College C1
where exists (select * from College C2 
				where C2.state = C1.state);
/*all college that is in the same state*/
/*wrong answer*/
/*C1 might have same collage with C2*/


select sName, state
from College C1
where exists (select * from College C2 
				where C2.state = C1.state and C1.cName <> C2.cName);

/*correct*/
------------------------------------------------
select cName
from College C1
where not exists (select * from College C2
					where C2.enrollment > C1.enrollment);

select  sName, GPA
from Student C1
where not exists (select * from Student C2 
					where C2.GPA > C1.GPA);

select S1.sName, S1.GPA
from Student S1, Student S2
where S1.GPA > S2.GPA;



