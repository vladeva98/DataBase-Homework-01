--Create  a database  called SEDCACADEMYDB•
--CREATE  6 Tables•
--Students•
--Teachers•
--Grades•
--Courses•
--AchievementTypes•
--GradeDetails


create database SEDCAKADEMYDB

use SEDCAKADEMYDB
go
-- 1
create table dbo.Students
(
  Id int identity (1,1),
  FirstName nvarchar(15) not null,
  LastName nvarchar (15) not null,
  City nvarchar (15) null,
  Age int not null
)

insert into dbo.Students(FirstName ,LastName,City,Age)
values ('Jovana','Vladeva','Sveti Nikole',24)

select * from dbo.Students

--2
create table dbo.Teachers
(
  Id int identity (1,1),
  FirstName nvarchar(15) not null,
  LastName nvarchar (15) not null,
  City nvarchar (15) null,
  Age int not null,
  Subjec nvarchar (15) not null
)

select * from dbo.Teachers

insert into dbo.Teachers(FirstName,LastName,City,Age,Subjec)
values('Dejana','Vladeva','Skopje',46,'Hemija')

--3

create table dbo.Grades
(
  Id int identity (1,1),
  MathGrade int not null,
  GeomethrGrade int not null,
  HistoryGrade int not null
)

select * from dbo.Grades

insert into dbo.Grades(MathGrade,GeomethrGrade,HistoryGrade)
values(5,4,3)

--4

create table dbo.Courses
(
  Id int identity (1,1),
  WebDevelopment nvarchar(15) not null,
  WebDesigner nvarchar (15) not null,
  DigitalMarketing nvarchar (15) null,
  
)

select * from dbo.Courses

insert into dbo.Courses( WebDevelopment,WebDesigner, DigitalMarketing)
values('FullStuck','Graphics','WebSites')

--5

create table dbo.AchievementTypes
(
  Id int identity (1,1),
  Scholarships nvarchar(15) not null,
  HonorRoll nvarchar (15) not null,
  Awards nvarchar (15) null,
 
)

select * from dbo.AchievementTypes

insert into dbo.AchievementTypes(Scholarships,HonorRoll,Awards)
values('yes','yes','no')

--6

create table dbo.GradeDetails
(
  Id int identity (1,1),
  A nvarchar(15) not null,
  B nvarchar (15) not null,
  C nvarchar (15) not null,
  D nvarchar (15) not null,
  E nvarchar (15) not null
)

select * from dbo.GradeDetails

insert into dbo.GradeDetails(A,B,C,D,E)
values('OutStanding','Very Good','Acceptable','Insufficient','NotAcceptable')