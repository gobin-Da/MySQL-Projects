use master
go

create database studentDataManage
go

use studentDataManage
go

create table Student
(
	Student_id int primary key identity(1,1),
	Student_Name varchar(30),
	Age int,
	Gender varchar(30),
	Grade_Level varchar(30),
	Attendance decimal(10, 2),
	GPA decimal(10, 2)
);
go

Insert into Student(Student_Name, Age, Gender, Grade_Level, Attendance, GPA)
			values('Abir', 12, 'Male','A', 80.5, 4),
				  ('Rishi', 11, 'Male','A', 84.5, 4),
				  ('Rahi', 12, 'Female','A', 82.7, 4),
				  ('Nishi', 11, 'Female','B+', 79.2, 3.5),
				  ('Antik', 12, 'Male','B+', 76.5, 3.5),
				  ('Nadia', 11, 'Femle','B-', 60.3, 3.25)
go

select * from Student
go

select avg(GPA) as Average_GPA
from Student
go

select * 
from Student
where Attendance between 75 and 100
go

select COUNT(Student_id) as Total_Student
from Student
go

--creating a table for the courses
create table Course
(
	Course_id int primary key identity(101, 1),
	Course_Name varchar(30),
	Duration varchar(30),
	Student_id int foreign key references Student(Student_id)
);
go

--alter table Course with a TeachersName column
alter table Course
add Teachers_Name varchar(30)

insert into Course(Course_Name, Duration, Student_id, Teachers_Name)
			values('Bangla', '1 year', 1, 'Mr Amin'	),
				  ('English', '1 year', 2,'Ms Shaila'),
				  ('Math', '1 year', 3,	'Mrs Ruhana'),
				  ('B.G.S', '1 year', 4,'Mr Ashis'),
				  ('Science', '1 year', 5,'Ms Anika'),
				  ('Drawing', '1 year', 6,'Mrs Arpa')
go


--truncate table Course

select * from Course 
go

select Student.Student_id, Student.Student_Name, Course.Course_id, Course.Course_Name, Course.Duration, Course.Teachers_Name
from Student 
Cross JOIN Course
order by Student.Student_id