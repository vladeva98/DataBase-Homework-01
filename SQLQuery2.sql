--Provide  script for inserting dummy data in already created  SEDCHome  database
--○Session 2 -06 Insert  example data in SEDCHome  database -data.sql






use SEDCAKADEMYDB
go

--○Find all Students  with FirstName = Antonio
Select *
from Students
where FirstName = 'Antonio'

--○Find all Students with DateOfBirth greater than ‘01.01.1999’
Select * 
from dbo.Students
where Age >= 23


--○Find all Students with LastName starting With ‘J’ enrolled in January/1998
select *
from dbo.Students
where LastName like 'V%' and EnroledDate = 'January/1998'


--○List all Students ordered  by FirstName
select *
from dbo.Students
order by FirstName desc

--○List all Teacher  Last Names and Student Last Names in single result set. Remove  duplicates

select * from dbo.Teachers
select * from dbo.Students

select LastName
from dbo.Teachers
union
select LastName
from dbo.Students



