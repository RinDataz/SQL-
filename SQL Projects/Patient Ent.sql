-- Patient: Represents an individual who receives blood with attributes like name, age, blood type, and contact details.

-- Table creation 
  create table Patient (
  Patient_ID NUMBER(5) NOT NULL PRIMARY KEY,
  Name VARCHAR2(20),
  Age NUMBER(5),
  Gender VARCHAR2(10),
  Blood_Type VARCHAR2(5),
  Contact_Details VARCHAR2(20));

-- Insertaion 
insert into Patient(patient_ID, Name, Age, Gender, Blood_Type, Contact_Details)
values(122, 'Fasil B.Ahmari', 35, 'M', 'O+', '501235657');

insert into Patient(patient_ID, Name, Age, Gender, Blood_Type, Contact_Details)
values(123, 'Sadeem T.Alharbi', 27, 'F', 'AB-', '560604460');

insert into Patient(patient_ID, Name, Age, Gender, Blood_Type, Contact_Details)
values(124, 'Amad M.Almalki', 22, 'M', 'B+', '580806622');

insert into Patient(patient_ID, Name, Age, Gender, Blood_Type, Contact_Details)
values(125, 'Reenad R.Alzahrani', 38, 'F', 'AB+', '595957723');

insert into Patient(patient_ID, Name, Age, Gender, Blood_Type, Contact_Details)
values(126, 'Sara A.alawadth', 29, 'F', 'O-', '507392649');

insert into Patient(patient_ID, Name, Age, Gender, Blood_Type, Contact_Details)
values(127, 'Murad S.samri', 45, 'M', 'B+', '506687454');

-- checking
Select * from Patient;
