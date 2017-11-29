select sID, sName, GPA
from Student 
where GPA > 3.6; 
-------------------------------------------------------------
select sName, major
from Student, Apply
where Student.sID = Apply.sID;
/* several duplication values */

select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID;
/* remove several duplication values */
-------------------------------------------------------------
select sName, GPA, decision
from Student, Apply
where Student.sID = Apply.sID
	and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

select distinct College.cName 
/*the same name in two tables. need to note as College.cName */
from College, Apply
where College.cName = Apply.cName
	and enrollment > 20000 and major = 'CS';

/*order of the result (unorder) and have a particular order */
/*clause resort by some particular attributes */

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName
order by GPA desc, enrollment;

select sID, major
from Apply
where major like '%bio%'; /* major followed by some chars. with bio then followed by some chars. */

select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) as scaled /*rename the label */
from Student;
-------------------------------------------------------------
-------------------------------------------------------------
/*union, intersect, except*/
select S.sID, sName, GPA, A.cName, enrollment
from Student S, College C, Apply A
where A.sID = S.sID and A.cName = C.cName;


select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID <> S2.sID;  
/**two different students/

/*dont want amy-doris doris-amy (twice)*/
select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID < S2.sID;  /*two different students*/

select cName as name from College
union
select sName as name from Student; /*sorted*/
/*union operator default is sorted*/

/*like JSON parallel*/

select cName as name from College
union all  
select sName as name from Student
order by name;
-------------------------------------------------------------
select sID from Apply where major = 'CS'
intersect
select sID from APply where major = 'EE';
/*student applied CS also applied EE*/

select A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major ='CS' and A2.major = 'EE';
/*All pair of student */

select distinct A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major ='CS' and A2.major = 'EE';
/*All pair of student withouth duplicate*/
-------------------------------------------------------------
select sID from Apply where major ='CS'
except
select sID from Apply where major = 'EE';
/*student apply CS but not EE*/

select A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major <> 'EE';
/*find all pair that same sID with CS but not EE could be other majors*/
/*might applied CS with other major not EE*/
/*different from the one that we worte with except*/
-------------------------------------------------------------
-------------------------------------------------------------




