--======hospital_management_system_ddl============--
use master
go

create database hospital_management_system
go

use hospital_management_system
go

--====== Creating table for Hospital Management System ========--
create table Patient
(
	Patient_ID int primary key,
	Patient_Name varchar(25) not null,
	Patient_Age int not null,
	Patient_Weight decimal(10, 2) not null,
	Patient_Gender varchar(25) not null,
	Patient_Address varchar(25) not null, 
	Patient_PhoneNo int not null,
	Patient_Disease varchar(30) not null, 
	Doctor_ID int not null
)
go

create table Doctor
(
	Doctor_ID int primary key,
	Doctor_Name varchar(25) not null,
	Doctor_Department varchar(25) not null
)
go


create table Lab
(
	Lab_No int primary key,
	Patient_ID int foreign key references Patient(Patient_ID),
	Patient_Weight decimal(10,2) not null,
	Doctor_ID int foreign key references Doctor(Doctor_ID),
	Date_Of_Admit datetime not null,
	Patient_Type varchar(25) check (Patient_Type in ('Critical', 'Emergency', 'Stable State')) not null,
	Lab_Charge Decimal(10,2) not null
)
go

create table InPatient
(
	Patient_ID int foreign key references Patient(Patient_ID),
	Room_No int not null,
	Date_Of_Admit datetime not null,
	Date_Of_Discharge datetime not null,
	Advance_Payment Decimal(10,2) not null,
	Lab_No int foreign key references Lab(Lab_No)
)
go

create table OutPatient
(
	Patient_ID int foreign key references Patient(Patient_ID),
	Date_Of_Discharge datetime not null,
	Lab_No int foreign key references Lab(Lab_No)
)
go

create table RoomTable
(
	Room_No int not null,
	Room_Type varchar(25) not null,
	Room_Status varchar(25) not null
)
go

create table Bill_Table
(
	Bill_No int primary key,
	Patient_ID int foreign key references Patient(Patient_ID),
	Patient_Type varchar(25) check (Patient_Type in ('Critical', 'Emergency', 'Stable State')) not null,
	No_Of_Days int not null,
	Doctor_Charge Decimal(10,2) not null,
	Medicine_Charge Decimal(10,2) not null,
	Room_Charge Decimal(10,2) not null,
	Operation_Charge Decimal(10,2) not null,
	Nursing_Charge Decimal(10,2) not null,
	Advance_Payment Decimal(10,2) not null,
	Lab_Charge Decimal(10,2) not null,
	Health_Card int not null,
	Total_Bill as (No_Of_Days * (Doctor_Charge+Medicine_Charge+Room_Charge+Operation_Charge+Nursing_Charge+Advance_Payment+Lab_Charge))
)
go

--======== Tables Created =========--

--======== Create proc for Patient, Doctor =======--
create proc sp_Patient
@patientid int,
@patientname varchar(25),
@patientage int,
@patientweight int,
@patientgender varchar(25),
@patientaddress varchar(25),
@patientphoneno int,
@patientdisease varchar(25),
@doctorid int,
@operationname varchar(25)
as 
begin
	if(@operationname = 'Insert')
	begin
		Insert into Patient(Patient_Name,Patient_Age,Patient_Weight,Patient_Gender,Patient_Address,Patient_PhoneNo,Patient_Disease,Doctor_ID)
				    values(@patientname, @patientage , @patientweight ,@patientgender, @patientaddress, @patientphoneno, @patientdisease, @doctorid)
	end

	if(@operationname = 'Update')
	begin
		Update Patient
		set Patient_Name = @patientname
		where Patient_ID = @patientid
	end

	if(@operationname = 'Delete')
	begin
		Delete from Patient
		where Patient_ID = @patientid
	end	
end
go

create proc sp_Doctor
@doctorid int,
@doctorname varchar(25),
@doctordepartment varchar(25),
@tablename varchar(25),
@opertationname varchar(25)
as
begin 
	if(@tablename = 'Doctor' and @opertationname = 'Insert')
	begin 
		Insert into Doctor(Doctor_Name, Doctor_Department)
					values(@doctorname, @doctordepartment)
	end

	if(@tablename = 'Doctor' and @opertationname = 'Update')
	begin
		update Doctor 
		set Doctor_Name = @doctorname, Doctor_Department = @doctordepartment
		where Doctor_ID = @doctorid
	end

	if(@tablename = 'Doctor' and @opertationname = 'Delete')
	begin
		Delete from Doctor 
		where Doctor_ID = @doctorid
	end
end
go
--================== End of Stored procedure ===========================

--================== Create trigger for Inpatient to Update the value into room ===================
create trigger trig_InpatientToRoom
on InPatient
after insert
as
begin
	declare @roomno int

	select @roomno = i.Room_No from inserted i;

	Update RoomTable
	set Room_Status = 'Clean', Room_Type = 'Full'
	where Room_No = @roomno

end
go

create trigger trig_removeFromRoom
on InPatient
after delete
as
begin
	declare @roomno int

	select @roomno = d.Room_No from deleted d;

	Update RoomTable
	set Room_Status = 'Not Clean', Room_Type = 'Empty'
	where Room_No = @roomno

end
go
--=================== Complete till now ==========================================

