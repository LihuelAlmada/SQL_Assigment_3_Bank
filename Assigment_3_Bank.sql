create database Assigment_3_Bank
use Assigment_3_Bank

Create table Clients(
ID_Client int primary key not null,
Last_Name_Client varchar (40) not null,
Name_Client varchar(40) not null,
DNI_Client int not null,
Phone_Client int not null,
Birthdate datetime not null
)

Create table Accounts(
ID_Account int primary key not null,
ID_Client int foreign key references Clients(ID_Client),
Type_Account int not null,
Balance decimal(7,2) not null
)

Create table Balances(
ID_Account int foreign key references Accounts(ID_Account),
Balance decimal(7,2) not null,
Date_Balance decimal(7,2) not null,
)

Create table Movements(
ID_Movements int primary key not null,
ID_Account int foreign key references Accounts(ID_Account),
Balance_Before decimal(7,2) not null,
Balance_After decimal(7,2) not null,
cost decimal(7,2) not null,
Date_Movement datetime not null,
)
GO
CREATE PROCEDURE spd_addClients
(@ID_Client int,
@Last_Name_Client nvarchar(100),
@Name_Client nvarchar(100),
@DNI_Client nvarchar(100),
@Phone_Client nvarchar(100),
@Birthdate datetime)
AS 
INSERT INTO CLIENTS
(ID_Client,Last_Name_Client, Name_Client, DNI_Client,Phone_Client,Birthdate)
VALUES
(@ID_Client,@Last_Name_Client,@Name_Client,@DNI_Client,@Phone_Client,@Birthdate)


exec spd_addClients
@ID_Client=3,
@Last_Name_Client='Lopez',
@Name_Client='Pedro',
@DNI_Client=25673333,
@Phone_Client=4355866,
@Birthdate='20/11/1960'
GO
Create procedure spd_addAccounts(
@ID_Account int,
@ID_Client int,
@Type_Account int,
@Balance decimal(7,2)
)
as
insert into Accounts
(ID_Account, ID_Client,Type_Account, Balance)
values
(@ID_Account, @ID_Client, @Type_Account, @Balance)

exec spd_addAccounts
@ID_Account=1,
@ID_Client=3,
@Type_Account=2,
@Balance=500
GO

Create procedure spd_addmovements (
@ID_Movements int,
@ID_Account int,
@Balance_Before decimal(7,2),
@Balance_After decimal(7,2),
@cost decimal(7,2),
@Date_Movement datetime
)
as
insert into Movements
(ID_Movements, ID_Account, Balance_Before, Balance_After, cost, Date_Movement)
values
(@ID_Movements, @ID_Account, @Balance_Before, @Balance_After, @cost, @Date_Movement)

exec spd_addmovements
@ID_Movements=1,
@ID_Account=1,
@Balance_Before=300,
@Balance_After=500,
@cost=200,
@Date_Movement='05/06/2019'
GO
Create procedure spd_delClient(
@ID_Client int
)
as
delete from Clients
where Clients.ID_Client=@ID_Client

exec spd_delClient
@ID_Client=1
GO
Create procedure spd_delAccount(
@ID_Account int
)
as
delete from Accounts
where Accounts.ID_Account=@ID_Account

exec spd_delAccount
@ID_Account=4
GO
Create procedure spd_delmovements(
@ID_Movements int
)
AS
Delete from Movements
where Movements.ID_Movements=@ID_Movements

exec spd_delmovements
@ID_Movements=2
GO
Create procedure spd_upclients
(@ID_Client int,
@Last_Name_Client nvarchar(100),
@Name_Client nvarchar(100),
@DNI_Client nvarchar(100),
@Phone_Client nvarchar(100),
@Birthdate datetime)
as
update Clients
set Last_Name_Client=@Last_Name_Client,
	Name_Client=@Name_Client,
	DNI_Client=@DNI_Client,
	Phone_Client=@Phone_Client,
	Birthdate=@Birthdate
where ID_Client=@ID_Client

exec spd_upclients
@ID_Client=1,
@Last_Name_Client='Monttorfano',
@Name_Client='Matias',
@DNI_Client=45685333,
@Phone_Client=4213169,
@Birthdate='1997-08-10'
GO
Create procedure spd_upaccounts(
@ID_Account int,
@ID_Client int,
@Type_Account int,
@Balance decimal(7,2)
)
as
update Accounts
set ID_Client=@ID_Client,
	Type_Account=@Type_Account,
	Balance=@Balance
where ID_Account=@ID_Account

exec spd_upaccounts

@ID_Account=5,
@ID_Client=4,
@Type_Account=2,
@Balance=70000
GO
create procedure  spd_upmovements(
@ID_Movements int,
@ID_Account int,
@Balance_Before decimal(7,2),
@Balance_After decimal(7,2),
@cost decimal(7,2),
@Date_Movement datetime
)
as
update Movements
set ID_Account=@ID_Account,
	Balance_Before=@Balance_Before,
	Balance_After=@Balance_After,
	cost=@cost,
	Date_Movement=@Date_Movement
where ID_Movements=@ID_Movements

exec spd_upmovements
@ID_Movements=3,
@ID_Account=5,
@Balance_Before=40000,
@Balance_After=70000,
@cost=30000,
@Date_Movement='02/05/2019'
GO
Create Procedure  spu_ObtainBalanceAccount(
@ID_Account int,
@Balance decimal(18,2) output)
as
Begin
	select @Balance=Accounts.Balance
		from Accounts
		where ID_Account=@ID_Account
		end

DECLARE @Balances decimal(10,2)
EXEC spu_ObtainBalanceAccount 1, @Balance output
PRINT @Balances
GO
Create procedure spd_MovementsAccount(
 @DateM datetime)
AS
BEGIN
SELECT Last_Name_Client, ID_Movements, Balance_Before, Balance_After,
cost, Date_Movement
FROM Movements INNER JOIN Accounts ON
Movements.ID_Account = Accounts.ID_Account inner join Clients on
Accounts.ID_Client = Clients.ID_Client
WHERE Date_Movement = @DateM
ORDER BY Date_Movement DESC
END

EXEC spd_MovementsAccount '02/05/2019'