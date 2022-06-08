
-- Calculate the count of all grades per Teacher in the system


Select  T.FirstName  as FirstName , T.LastName as LastName ,SUM(Grade) as AllGrades, T.AcademicRank as AcademicRank
from 
dbo.[Teacher] as T
inner join dbo.[Grade] as G ON G.TeacherID = T.ID 
GROUP BY   T.FirstName,T.LastName , G.Grade , T.AcademicRank


-- Find the Maximal Grade, and the Average Grade per Student on all grades in the system

Select S.FirstName as StudentFirstName , S.LastName as StudentLastName ,MAX(Grade) as MaximalGrade , AVG(Grade) as AverageGrade 
From
dbo.[Grade] as G
inner join dbo.[Student] as S ON S.ID = G.StudentID
GROUP BY S.FirstName , S.LastName


-- Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200

Select  T.FirstName  as FirstName , T.LastName as LastName ,SUM(Grade) as AllGrades, T.AcademicRank as AcademicRank
from 
dbo.[Teacher] as T
inner join dbo.[Grade] as G ON G.TeacherID = T.ID 
GROUP BY   T.FirstName,T.LastName , G.Grade , T.AcademicRank 
HAVING SUM(Grade) > 200


-- Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. 
--Filter only records where Maximal Grade is equal to Average Grade
--List Student First Name and Last Name next to the other details from previous query


Select S.FirstName as StudentFirstName,S.LastName as StudentLastName,G.Grade as Grade , MAX(Grade) as MaximalGrade , AVG(Grade) as AverageGrade 
From
dbo.[Grade] as G
inner join dbo.[Student] as S ON S.ID = G.StudentID
group by S.FirstName , S.LastName , G.Grade
having max(Grade) = avg(Grade)

-- Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student

create view dbo.vv_StudentGrades
as 
select Student.ID As StudentId
from dbo.Student
group by Student.ID

Select * from dbo.vv_StudentGrades

alter view dbo.vv_StudentGrades
as
select S.ID AS StudentId , G.Grade AS CountGrade
from
dbo.Grade as G
inner join dbo.[Student] as S ON S.ID = G.StudentID
group by  S.ID , G.Grade

Select * from dbo.vv_StudentGrades

-- Change the view to show Student First and Last Names instead of StudentID
alter view dbo.vv_StudentGrades
as
select S.FirstName AS StudentFirstName , S.LastName as StudentLastName , G.Grade as GradeCount 
from 
dbo.Grade as G
inner join dbo.[Student] as S on S.ID = G.StudentID
group by  S.FirstName , S.LastName , G.Grade

Select * from dbo.vv_StudentGrades

 -- List all rows from view ordered by biggest Grade Count
 select * from dbo.vv_StudentGrades
order by GradeCount DESC
