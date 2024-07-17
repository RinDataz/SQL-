-- Donor: Represents an individual who donates blood with attributes like name, age, blood type, and contact details.

-- Table creation 
   create table Donor( 
    Donor_ID NUMBER(5) NOT NULL PRIMARY KEY,
     Name VARCHAR2(20),
    Age NUMBER(5),
    Gender VARCHAR2(20),
    Blood_Type VARCHAR2(5),
    Contact_Details  VARCHAR2(20),
    BloodBank_ID NUMBER(10),
    FOREIGN KEY (BloodBank_ID) REFERENCES BloodBank(BloodBank_ID) );

-- Insertaion 
insert into Donor(Donor_ID,Name,Age,Gender,Blood_Type,Contact_Details,BloodBank_ID)
Values(222,'Mark A.zaid',22,'M','O-','552630614',7022);
insert into Donor(Donor_ID,Name,Age,Gender,Blood_Type,Contact_Details,BloodBank_ID)
Values(223,'Nora B.aAbdullah',23,'F','A-','552310816',2800);
insert into Donor(Donor_ID,Name,Age,Gender,Blood_Type,Contact_Details,BloodBank_ID)
Values(224,'Aseel D.fahad',33,'F','AB-','536317718',3390);
insert into Donor(Donor_ID,Name,Age,Gender,Blood_Type,Contact_Details,BloodBank_ID)
Values(225,'Basma Hassan',26,'F','O+','542515511',3390);
insert into Donor(Donor_ID,Name,Age,Gender,Blood_Type,Contact_Details,BloodBank_ID)
Values(226,'Hashim Jamal',37,'M','O-','559390899',4980);
insert into Donor(Donor_ID,Name,Age,Gender,Blood_Type,Contact_Details,BloodBank_ID)
Values(227,'Abass L.Waleed',19,'M','B-','552567817',2309);

-- checking
select * from Donor