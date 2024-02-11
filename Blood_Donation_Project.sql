use master 
go

create database BloodDonationManagementProj
go

use BloodDonationManagementProj
go


create table Patient
(
	Patient_ID int Primary Key NOT NULL,
	Patient_Name varchar(30) NOT NULL,
	Blood_Group varchar(30) NOT NULL,
	Disease varchar(30) NOT NULL,
	Patient_Contact varchar(12) NOT NULL,
	Patient_Address varchar(30) NOT NULL
)
go

create table Donor
(
	Donor_ID int Primary Key NOT NULL,
	Donor_Name varchar(30) NOT NULL,
	Medical_Report varchar(30) NOT NULL check(Medical_Report in('Satisfactory', 'Not Satisfactory')),
	Donor_Address varchar(30) NOT NULL,
	Donor_Blood_Group varchar(30) NOT NULL,
	Donor_Contact varchar(30) NOT NULL
)
go

create table Blood_Bank
(
	Blood_Bank_ID int primary key NOT NULL,
	Blood_Bank_Name varchar(30) NOT NULL,
	Blood_Bank_Address varchar(30) NOT NULL,
	Blood_Bank_Contact varchar(30) NOT NULL,
	Donor_ID int Foreign Key references Donor(Donor_ID),
)
go

--Insert Values Into Patient
Insert into Patient(Patient_ID, Patient_Name, Blood_Group, Disease, Patient_Contact, patient_Address)
			values(101, 'Korim Rahman', 'A+', 'B', '01701231231', 'Vedvedi'),
				  (102, 'Anowara Begum', 'AB-', 'O', '01934123112', 'College Road'),
				  (103, 'Shankar Misra', 'O+', 'AB', '01891231231', 'Kollyanpur Road'),
				  (104, 'Azizul Haq', 'B+', 'A', '01671231231', 'Tabalchori'),
				  (105, 'Ronel Chakma', 'AB+', 'O', '01552345763', 'Reserve Bazar'),
				  (106, 'Ratan Baiddya', 'B-', 'A', '01981281324', 'Kalindipur')
go

--Insert Values Into Donor
Insert into Donor(Donor_ID, Donor_Name, Medical_Report, Donor_Address, Donor_Blood_Group, Donor_Contact)
			values(201, 'Obaidul Rahim', 'Satisfactory', 'Ashambosti Bazar', 'O+', '01872234516'),
				  (202, 'Ashish Dey', 'Satisfactory', 'Tabalchori', 'A+', '01423423219'),
				  (203, 'Antik Chakma', 'Not Satisfactory', 'Banarupa', 'B+', '01987634562'),
				  (204, 'Nobarun Khisa', 'Satisfactory', 'Vedvedi', 'AB+', '01882345162'),
				  (205, 'Baishaki Tripura', 'Satisfactory', 'College Road', 'B-', '01556734253'),
				  (206, 'Alim Hossain', 'Not Satisfactory', 'Reserve Bazar', 'A+', '01632423121')
go

--Insert Values Into Blood Bank
Insert Into Blood_Bank(Blood_Bank_ID, Blood_Bank_Name, Blood_Bank_Address, Blood_Bank_Contact, Donor_ID)
			values(301, 'Badhon', 'Banarupa', '01553212345', 203),
			      (302, 'Rokto', 'Reserve Bazar', '01897234125', 206),
			      (303, 'Oikko', 'Tabalchari', '01723465718', 202),
			      (304, 'Asha Ltd.', 'Vedvedi', '019812354627', 204)
go

select * from Patient
select * from Donor
select * from Blood_Bank
go

--Create Store Procedure to Insert value into above tables
create proc sp_InsertData
@patientid int,
@patientname varchar(30),
@bloodgroup varchar(30),
@disease varchar(30),
@patientcontact varchar(30),
@patientaddress varchar(30),
@donorid int,
@donorname varchar(30),
@medicalreport varchar(30),
@donoraddress varchar(30),
@donorbloodgroup varchar(30),
@donorcontact varchar(30),
@bloodbankid int,
@bloodbankname varchar(30),
@bloodbankaddress varchar(30),
@bloodbankcontact varchar(30),
@tablename varchar(30),
@operationname varchar(30)
AS
BEGIN
	if(@tablename='Patient' and @operationname='Insert')
	begin
		Insert into Patient(Patient_ID, Patient_Name, Blood_Group, Disease, Patient_Contact, patient_Address)
					values(@patientid, @patientname, @bloodgroup, @disease, @patientcontact, @patientaddress)
	end

	if(@tablename='Donor' and @operationname='Insert')
	begin
		Insert into Donor(Donor_ID, Donor_Name, Medical_Report, Donor_Address, Donor_Blood_Group, Donor_Contact)
					values(@donorid, @donorname, @medicalreport, @donoraddress, @donorbloodgroup ,@donorcontact)
	end

	if(@tablename='Blood_Bank' and @operationname='Insert')
	begin 
		Insert Into Blood_Bank(Blood_Bank_ID, Blood_Bank_Name, Blood_Bank_Address, Blood_Bank_Contact, Donor_ID)
					values(@bloodbankid, @bloodbankname, @bloodbankaddress, @bloodbankcontact, @donorid)
	end

END

-- Exec sp_InsertData 107, 'Arjit Sing', 'AB-', 'O', '01723415876', 'College Road', 0,0,0,0,0,0,0,0,0,0, 'Patient', 'Insert'

