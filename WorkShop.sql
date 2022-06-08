use SEDC
go

--1) Да се искреира табела dbo.businessentity_details 
--Табелата треба да има foreign key со табелата BusinessEntity.ID.

create table dbo.businessentity_details
(
	ID int identity (1,1) primary key ,
	BusinessentityID int constraint fk_BusinessEntityD foreign key (BusinessentityID) references dbo.Businessentity(Id),
	AccountNumber  nvarchar(15)not null,
	[Address] nvarchar(250)not null,
	Contact nvarchar(100)not null,
	email nvarchar(250) not null,
	comment nvarchar(MAX) null,
	
	
	
)
select*
from dbo.businessentity_details


drop table dbo.businessentity_details



--3-- insert values
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(1,'210500222333','Partizanski Odredi 15','070555666','aaa@vitalia.com','Nema zabeleshka')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(2,'210500222334','XXXX 15','070779523','bbb@vitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(3,'210500222335','XXXX 16','070779523','ccc@vitalia.com','TEST 1')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(4,'210500222335','XXXX 17','070779523','dddvitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(5,'210500222336','XXXX 18','070779544','vvv@vitaliacom','Nema plateno faktura')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(6,'210500222337','XXXX 19','070779555','ddd@vitaliacom',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(7,'210500222338','XXXX 20','070779566','aa@vitalia.com','Nevaliden kontakt')
go


--2)Колоната emailтреба да проверува дали содржи знак @ и знак “.”
alter table dbo.businessentity_details with check
add constraint email check(email like '%@%.%')


--3)Првите два знака од колоната Contactтреба да бидат 07
alter table dbo.businessentity_details with check 
add constraint Contact check (substring (Contact,1,2) = '07')


update dbo.businessentity_details set email = 'ddd@vitalia.com' where ID = 4
update dbo.businessentity_details set email = 'vvv@vitalia.com' where ID = 5
update dbo.businessentity_details set email = 'ddd@vitalia.com' where ID = 6


--4)Да се направи UPDATE на колона comment со вредност:
--Nema zabaleshka za smetkaна сите колини од табелата dbo.businessentity_details

update dbo.businessentity_details set comment = 'Nema zabaleshka za smetkana' where ID in (1,2,3,4,5,6,7)


--5)Да се искреира функција за пресметка на вкупна количина на нарачки по продукт

alter function dbo.fn_QuantityofProduct(@ProductId INT)
returns nvarchar(200) 
as
begin

               declare @Result nvarchar(200)
			
			   select @Result  = sum(dbo.Product.Id * dbo.OrderDetails.OrderId)
			   from dbo.OrderDetails , dbo.Product
			   where OrderId= @ProductId
			   return @Result

end

select dbo.fn_QuantityofProduct(6)



-- 5)Да се искреира функција за пресметка на вкупна сума на нарачки по продукт

alter function dbo.fn_TotalAmound(@ProductId int)
returns nvarchar(200) 
as
begin

               declare @Result nvarchar(200)
			
			   select @Result  = SUM(dbo.Product.Cost * dbo.OrderDetails.OrderId)
			   from dbo.OrderDetails , dbo.Product
			   where OrderId= @ProductId
			   return @Result

end

select dbo.fn_TotalAmound(14)



--7)Потребно е да се направи view за приказ на:
--име на компанија-регион
--(пошта -име на регион)
--број на сметка-адреса, 
--вредноста XXXXда се замени со ‘Улица број’-
--име на продукт

select * from dbo.businessentity_details


update dbo.businessentity_details set Address = 'Ulica Broj 2' where ID = 2
update dbo.businessentity_details set Address = 'Ulica Broj 3' where ID = 3
update dbo.businessentity_details set Address = 'Ulica Broj 4' where ID = 4
update dbo.businessentity_details set Address = 'Ulica Broj 5' where ID = 5
update dbo.businessentity_details set Address = 'Ulica Broj 6' where ID = 6
update dbo.businessentity_details set Address = 'Ulica Broj 7' where ID = 7


alter view dbo.vv_BusinessEntityDetails
as
select  BE.Name AS CompanyName , Be.Region as Companyregion, BED.AccountNumber as AccountNumber , BED.Address as Address  , p.Name as ProductName
from dbo.businessentity_details as BED
inner join dbo.BusinessEntity as BE ON BE.Id = BED.ID
inner join dbo.[Order] as O ON O.BusinessEntityId = BE.Id
inner join dbo.OrderDetails as OD ON OD.OrderId = O.Id
inner join dbo.Product as P on P.Id = od.ProductId
group by BE.Name , Be.Region ,BED.AccountNumber,BED.Address , P.Name


select * from  dbo.vv_BusinessEntityDetails
