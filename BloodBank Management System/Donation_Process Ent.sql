--Donation Process: Represents the event of blood donation with attributes like date, amount donated, and donor ID.Donation Process: Represents the event of blood donation with attributes like date, amount donated, and donor ID.

-- Table creation 
  Create table Donation_Process(
   Donation_ID NUMBER(10)  NOT NULL PRIMARY KEY ,
    Date_of_donation DATE,
   Amount_donated NUMBER(2),
    Donor_ID NUMBER(10),
   FOREIGN KEY (Donor_ID) REFERENCES Donor(Donor_ID)    
);

-- Insertaion 
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated,Donor_ID )
values(10009,'20-JAN-23',2,222);
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated,Donor_ID )
values(10010,'22-JAN-23',2,223);
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated ,Donor_ID )
values(10011,'20-JAN-23',1,224);
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated,Donor_ID )
values(10012,'12-DEC-23',1,222);
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated,Donor_ID )
values(10013,'15-APR-23',3,225);
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated,Donor_ID )
values(10014,'15-OCT-23',3,226);
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated ,Donor_ID )
values(10018,'17-NOV-23',1,222);
Insert into Donation_Process(Donation_ID ,Date_of_donation , Amount_donated,Donor_ID )
values(10019,'01-DEC-23',2,223);  

-- checking
select * from Donation_Process