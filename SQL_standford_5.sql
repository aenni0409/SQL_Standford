/*NULL value*/
/*value is undefinied or not exists*/
 .read Schema.sql
 .read Data.sql

insert into Student values (432, 'Kevin',null,1500);
insert into Student values (321, 'Lori', null,2500);

select sID, sName, GPA
from Student
where GPA > 3.5;
/*dont have kevin and lori*/

select sID, sName, GPA
from Student
where GPA > 3.5;
/*dont have kevin and lori*/

select sID, sName, GPA
from Student
where GPA <= 3.5;
/*still dont have kevin and lori*/

select sID, sName, GPA
from Student
where GPA > 3.5 or GPA <= 3.5;
/*still dont have kevin and lori*/

select sID, sName, GPA
from Student
where GPA > 3.5 or GPA <= 3.5 or GPA is NULL;
/*all dataset*/
------------------------------------------------
select sID, sName, GPA
from Student
where GPA > 3.5 or sizeHS < 1600;
/*include kevin and lori cannot define gpa for these two*/


select sID, sName, GPA
from Student
where GPA > 3.5 or sizeHS < 1600 or sizeHS >= 1600;
/*all students*/
--------------------------------------------------
select count(*)
from Student
where GPA is not null;

select count(distinct GPA)
from Student
where GPA is not null;

select count(distinct GPA)
from Student;

select distinct GPA
from Student;
/*Null value is empty include the result*/
















