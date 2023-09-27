--Documentation For DB Banking System SQL Code Implementation
--MS-SQL PROJECT on Banking System 

--PHASE I of project begins

--1)Q1.Create a database for a banking application called ‘Union_Bank’ 
-----Using Our Database ‘Union_Bank'

create database Union_Bank
go

USE Union_Bank
go

--2)Q2.Create all the tables mentioned in the database diagram.
--create tables & add constraint Section 
--3)	Q3. Create all the constraints based on the database diagram.

--Creating table named Customers
create table Customers 
(
CustomerId int primary key identity(1,1),
FirstName varchar(50) not null,
LastName varchar(50) not null,
Gender varchar(1) not null,
Email varchar(50) not null,
BirthDate date not null,
Age as year(getdate())-year (BirthDate),
City varchar(50) not null,
State varchar(50) not null,
constraint ch1 check(Gender in ('m','f'))
);
go

--Creating table named Customer_phones
create table Customer_phones 
(
CustomerId int,
phone varchar(50) not null,
constraint  Customer_phones_IDS primary key (CustomerId, phone),
constraint Customer_phones_Customers foreign key (CustomerId) 
references Customers (CustomerId)
);
go

--Creating table named Branch
create table Branch 
(
BranchId int primary key,
BranchName varchar(50) not null,
Branch_Location varchar(50) not null,
);
go

--Creating table named Account
create table Account 
(
AccountNumber int primary key, 
AccountType varchar(50) ,
Balance float not null,
OpenDate date default getdate(),
Account_Status varchar(30) not null,
Branchid INT,
CustomerId int,
constraint customer_Account foreign key (CustomerId)
references Customers (CustomerId) ,
constraint Branch_Account foreign key (Branchid)
references Branch (BranchId) ,
constraint ch2 check(Account_status in ('active','not active')),
);
go

---we can check on account type through this constraint to check if 
--- the account saving or current ---
alter table account add constraint check_status check(accounttype in ('saving','current'))

--Creating table named Transactions
create table Transactions 
(
Transaction_Type_Id int primary key identity (1,1),
TransactionType varchar(30) not null,
);
go

--Creating table named Card */
create table Card (
CardNumber int primary key,
CardType varchar(30) not null,
card_Status varchar (30) not null,
ExpiryDate date not null,
AccountNumber int,
constraint Card_Account  foreign key (AccountNumber)
references Account (AccountNumber) 
);
go

--Creating table named Employee
create table Employee (
EmployeeId int primary key,
FirstName varchar(30) NOT NULL,
LastName varchar(30) NOT null,
Salary DECIMAL NOT NULL,
Position varchar(50) NOT NULL,
SupervisorID int ,
branchid INT,
Dno INT ,
constraint super_Employee foreign key(SupervisorID)
REFERENCES Employee (EmployeeId) ,
CONSTRAINT branchid_Employee foreign key(branchid)
references branch(branchid) ,
);
go

--create table named Department
CREATE TABLE Department 
(
Dnumber INT PRIMARY KEY ,
Dname VARCHAR(50) NOT NULL,
MgriD INT ,
constraint manager_Employee foreign key(MgriD)
REFERENCES Employee (EmployeeId) 
)

ALTER TABLE employee 
ADD constraint Dno_Employee foreign key(Dno)references Department (DNumber) 

--Creating table named Loan
create table Loan (
LoanId int primary key,
Amount decimal not null,
loan_months_terms int not null,
LoanType varchar(30) not null,
StartDate date not null,
EndDate date not null,
InterestRate varchar(20) not null,
customerid int,
BranchId int,
constraint Loan_customer foreign key (customerid)
references Customers (customerid),
constraint Loan_Branch foreign key (BranchId)
references Branch (BranchId)
);
go


--Creating table named ATM
create table ATM (
AtmId int primary key,
Atm_location varchar(50) NOT NULL,
Atm_status varchar(30) NOT NULL ,
BranchId int,
constraint ATM_Branch foreign key (BranchId)
references Branch(BranchId)
);
GO

--create table Account_Atm_transcation
CREATE TABLE Account_Atm_transcation
(
TransactionDate  DATE DEFAULT GETDATE() ,
AccountNumber INT,
transactionid INT identity(1,1) primary key,
Transaction_Type_Id int,
Atmid INT ,
Amount FLOAT NOT NULL, 
CONSTRAINT Atm_account_transcation foreign key (AccountNumber) references Account(AccountNumber),
CONSTRAINT transcation_Account_Atm foreign key (Transaction_Type_Id) references Transactions(Transaction_Type_Id)
);
go
--------------------------------------------------------------------------------------
----4)	Q4. Insert at least 10 rows in each table.

--insert data to Customers tables
insert into Customers
values
('Emmanuel','Akpobari','m','EmmanuelAkpobari@gmail.com','1982/8/2','GREENWOOD','Arizona'),
('Adetokunbo','Adeniyi','f','AdetokunboAdeniyi@yahoo.com','1995/6/12','Los Angeles','Colorado'),
('Qudus','Ademola','m','QudusAdemola@yahoo.com','1995/5/7','GREENWOOD','Idaho'),
('Chidinma','Nwankwo','f','ChidinmaNwankwo@gmail.com','1993/2/2','SIOUX FALLS','New York'),
('Chukwuemeka','Nnamani','m','ChukwuemekaNnamani@gmail.com','1990/2/2','Houston','Alaska'),
('Obinna','Eze','f','ObinnaEze@outlook.com','1986/10/12','Fort Worth','Georgia'),
('Jideofor','Oni','m','JideoforOni@gmail.com','1999/5/15','Oklahoma','newyork'),
('Jideofor','Oni','m','JideoforOni@gmail.com','1999/5/15','Texas','newyork'),
('moo','kevin','m','mokivin@gmail.com','1970/05/15','Athens','florida'),
('peter','peter','m','peter@gmail.com','1969/5/15','Huntsville','california')


--- insert 10 rows data to customer table
insert into Account (AccountNumber , AccountType, Balance,account_Status,CustomerId)
values (1001, 'saving',50500,'active',1 ),
(1002, 'current',5000,'active',2 ),
(1003, 'saving',70000,'active',3),
(1004, 'saving',1500,'active', 4),
(1005, 'current',56000,'active',5 ),
(1006, 'currnet',10000,'active', 6),
(1007, 'saving',44500,'active', 7),
(1008, 'current',50000,'active', 8),
(1009, 'currnet',19600,'active', 9),
(1010, 'currnet',9500,'active', 10)

--- insert types of transactions to Transactions table
insert into Transactions (TransactionType)
values ('Withdrawal'),
('Deposit'),
('Balance Inquiry'),
('Transfer')

--- insert data to department table 
insert into department (Dnumber,dname)
values(10,'D1'),
(20,'D2'),
(30,'D3')

--- insert data to Employee table 
INSERT INTO Employee(EmployeeId, FirstName, LastName, Salary, Position, SupervisorID, branchid, Dno)
VALUES
(1, 'mark', 'tomas', 10000, 'account', NULL, 1, 10),
(2, 'george', 'andro', 12000, 'engineer', 1, 2, 10),
(3, 'john ', 'mark ', 14000, 'engineer', 2, 3, 10),
(4, 'tony', 'justen', 11000, 'Hr', 2, 4, 10),
(5, 'robert', 'jack', 14000, 'iT', NULL, 5, 20),
(6, 'meshel', 'adam', 15000, 'admin', 5, 6, 20),
(7, 'skiler', 'beter', 3000, 'pr', 5, 7, 20),
(8, 'nancy', 'joee', 5000, 'sales', NULL, 8, 30),
(9, 'sara', 'whilem', 7000, 'office', 8, 9, 30),
(10, 'devid', 'geogre', 10000, 'manger it ', 8, 10, 30)


--- insert data to Customer_phones table 
insert into Customer_phones 
values (1,5628741234),
(2,5629753388),
(3,3109993628),
(4,7148473366),
(5,7149975885),
(6,7149972428),
(7,5625611921),
(8,7149688201),
(9,5627867727),
(10,5922565527)

--- insert data to Loan table 
INSERT INTO Loan(LoanID,Amount,loan_months_terms,LoanType,Startdate,Enddate,Interestrate,CustomerId,BranchID)
VALUES
(001002, 116500, 42,'micro', '2022/10/2','2024/2/20',4.56,2, 1),
(001003, 206500, 104,'micro', '2022/1/1','2025/5/30',4.25,3, 2),
(001005, 406500, 45, 'macro', '2021/3/3','2022/8/20',4,7, 3),
(001006, 456500, 85,'macro', '2020/5/4','2023/2/22',3.99,9, 4),
(001008, 696500, 140,'micro', '2019/2/8','2023/9/9',4.5,1, 5),
(001011, 706500, 122,'micro', '2022/9/9','2026/9/9',4.125,4, 6),
(001013, 346500, 82,'macro', '2021/5/25','2024/2/2',4.875,10, 7),
(001014, 266500, 140,'micro', '2019/3/3','2023/10/9',3.49,5, 8),
(001018, 376500, 99,'sme', '2021/9/3','2024/12/9',4.375,8, 9),
(001020, 436500, 107,'sme', '2019/8/4','2023/2/9',3.625,6, 10)

--- insert data to ATM table 
insert into ATM (AtmId,Atm_location,Atm_status,BranchId)
values (200,'Alabama','withdawals',1),
(201,'Alaska','deposit',2),
(202,'Arizona','transfer',5),
 (203,'california','withdawals',3),
 (204,'newyork','withdawals',10),
 (205,'newyork','withdawals',3),
 (206,'mayami','withdawals',2),
 (207,'florida','withdawals',3),
 (208,'Arkansas','withdawals',1),
 (209,'California','deposit',4),
 (210,'Colorado','transfer',6),
 (211,'Connecticut','transfer',7),
 (212,'Delaware','deposit',8),
 (213,'District of Columbia','withdawals',9)

--- insert data to Account_Atm_transcation table
insert into Account_Atm_transcation (accountnumber, Atmid, Amount, transaction_type_id,transactiondate )
values(1001,200,5000, 1, '2023-8-19'),
(1001,201,2000, 2, '2023-8-19'),
(1002,201,3000, 2, '2023-8-19'),
(1003,210,0, 3, '2023-8-19'),
(1006,209,6000, 4, '2023-8-19'),
(1008,207,8000, 1, '2023-8-19'),
(1009,206,0, 3, '2023-8-19'),
(1007,205,1000, 4, '2023-8-19'),
(1001,204,10000, 1, '2023-8-19'),
(1005,203,20000, 1, '2023-8-19')
 

create or alter function dbo.CalculateMonthlypayment2(
@interest_rate float,
@loan_amount float,
@loan_termmonths int,
@monthly_interestrate float)
returns float
as 
begin 
	set @monthly_interestrate = @interest_rate/(12*100) ;
	return ( @loan_amount*@monthly_interestrate) / (1 - power(1+ @monthly_interestrate,-@loan_termmonths)) ;
End;
go

select dbo.CalculateMonthlypayment2(4.56,116500,42,0.0038) as [Monthly Loan Payment] 
select dbo.CalculateMonthlypayment2(4.25,206500,104,0.0035)


create or alter function dbo.calculateInterestAmount(
@loan_amount float,
@interest_rate float,
@loan_termmonths int)
returns float
as
begin
	return @loan_amount*(@interest_rate/(12*100))*@loan_termmonths
end;
go
select dbo.calculateInterestAmount(1000,10,12) as [Interest Amount]