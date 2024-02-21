--============== This is the DML file =====================--
use hospital_management_system
go

insert into Patient(Patient_ID, Patient_Name, Patient_Age, Patient_Weight, Patient_Gender, Patient_Address, Patient_PhoneNo, Patient_Disease, Doctor_ID)
			values (1, 'Robiul Hasan', 45, 67, 'Male', 'Banarupa Bajar', 01723456781, 'dengie', 1),
				   (2, 'Anamika shaha', 36, 45, 'Feale', 'Reserve Bajar', 01897654321, 'Skin Diesese', 2),
				   (3, 'sourov Datta', 60, 77, 'Male', 'Tabalchari', 01723456781, 'Colon Cancer', 3),
				   (4, 'Rakib Hossain', 42, 88, 'Male', 'Banarupa Bajar', 01723456781, 'dengie', 1),
				   (5, 'Dipti Das', 32, 50, 'Feale', 'College Gate', 01723456781, 'Ulcer', 3)
go

insert into Doctor (Doctor_ID, Doctor_Name, Doctor_Department)
			values (1, 'Dr Adbur Hakim', 'Infectious Disease'),
				   (2, 'Dr Hridita dey', 'Hematologist'),
				   (3, 'Dr Ankit Chakma', 'Gastroenterologist')
go

insert into Lab (Lab_No, Patient_ID, Patient_Weight, Doctor_ID, Date_Of_Admit, Patient_Type, Lab_Charge)
			values (1, 1, 67, 1, GETDATE(), 'Critical', 500),
				   (2, 2, 45, 2, GETDATE(), 'Stable State', 500),
				   (3, 3, 77, 3, GETDATE(), 'Emergency', 1000),
				   (4, 4, 88, 1, GETDATE(), 'Critical', 800),
				   (5, 5, 50, 3, GETDATE(), 'Emergency', 1200)
go

Insert into RoomTable(Room_No, Room_Type, Room_Status)
			values(1, 'Empty', 'Not Clean'),
				  (2, 'Empty', 'Not Clean'),
				  (3, 'Empty', 'Clean')
go


select * from Doctor
go

select * from Patient
go

select * from RoomTable
go

select * from Lab
go

insert InPatient(Patient_ID, Room_No, Date_Of_Admit, Date_Of_Discharge, Advance_Payment, Lab_No)
	   values(1, 1, GETDATE(), GETDATE(), 1000, 1)
go

insert InPatient(Patient_ID, Room_No, Date_Of_Admit, Date_Of_Discharge, Advance_Payment, Lab_No)
	   values(2, 2, GETDATE(), GETDATE(), 1500, 2)
go

delete from InPatient where Patient_ID = 2

select * from InPatient
select * from RoomTable

truncate table RoomTable
truncate table InPatient