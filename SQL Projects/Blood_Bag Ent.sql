--Blood Bag: Represents a physical unit of stored blood with attributes like availability and the donation ID it originated from.

-- Table creation 
table creation:
   Create table Blood_Bag(
   BloodBag_ID NUMBER(5) NOT NULL PRIMARY KEY, 
   Available varchar2(10),
  Donation_ID NUMBER(10),
  Intake_ID NUMBER(10),   
  FOREIGN KEY (Donation_ID) REFERENCES Donation_Process(Donation_ID), 
  FOREIGN KEY (Intake_ID) REFERENCES Intake_Process(Intake_ID)  );

-- Insertaion 
insert into Blood_Bag(BloodBag_ID, Available ,Donation_ID,Intake_ID)
values(1100,'N',10009,2001);

insert into Blood_Bag(BloodBag_ID, Available ,Donation_ID,Intake_ID)
values(1101,'N',10009,2001);

insert into Blood_Bag(BloodBag_ID, Available ,Donation_ID,Intake_ID)
values(1102,'N',10010,2002);

insert into Blood_Bag(BloodBag_ID, Available ,Donation_ID,Intake_ID)
values(1103,'N',10010,2003);

insert into Blood_Bag(BloodBag_ID, Available ,Donation_ID,Intake_ID)
values(1104,'N',10011,2004);

insert into Blood_Bag(BloodBag_ID, Available ,Donation_ID,Intake_ID)
values(1105,'Y',10012,NULL);

-- checking
select * from Blood_Bag 