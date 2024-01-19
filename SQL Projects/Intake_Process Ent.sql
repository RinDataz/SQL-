-- Intake Process: Represents the event of blood transfusion to a patient with attributes like date, intake amount, patient ID, and blood bag ID.Intake Process: Represents the event of blood transfusion to a patient with attributes like date, intake amount, patient ID, and blood bag ID.

-- Table creation 
   create table Intake_Process(
   Intake_ID NUMBER(10) NOT NULL  PRIMARY KEY,
   Date_of_intake DATE,
    Intake_amount NUMBER(2),
   Patient_ID NUMBER(10),
   FOREIGN KEY(Patient_ID) references Patient(Patient_ID)
   );

-- Insertaion 
insert into Intake_Process(Intake_ID,Date_of_intake,Intake_amount,Patient_ID)
values(2001,'20-JAN-23',2,122);
insert into Intake_Process(Intake_ID,Date_of_intake,Intake_amount,Patient_ID)
values(2002,'22-JAN-23',1,122);
insert into Intake_Process(Intake_ID,Date_of_intake,Intake_amount,Patient_ID)
values(2003,'22-JAN-23',1,123);
insert into Intake_Process(Intake_ID,Date_of_intake,Intake_amount,Patient_ID)
values(2004,'22-JAN-23',1,124);
insert into Intake_Process(Intake_ID,Date_of_intake,Intake_amount,Patient_ID)
values(2005,'12-DEC-23',1,125);
insert into Intake_Process(Intake_ID,Date_of_intake,Intake_amount,Patient_ID)
values(2006,'15-APR-23',1,126);
insert into Intake_Process(Intake_ID,Date_of_intake,Intake_amount,Patient_ID)
values(2007,'16-OCT-23',3,127);

-- checking
select * from Intake_Process;
