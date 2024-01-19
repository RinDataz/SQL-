--1
-- Procedure to get the donor and blood information for the specifed type 

CREATE OR REPLACE PROCEDURE GetBloodTypeInformation(pBlood_Type IN VARCHAR2) 
AS 
BEGIN 
FOR donor_rec IN (SELECT D.Donor_ID, D.Name, D.Blood_Type, B.Bank_name
                      FROM Donor D
                      JOIN BloodBank B ON D.BloodBank_ID = B.BloodBank_ID
                      WHERE D.Blood_Type = pBlood_Type) 
  LOOP 
  DBMS_OUTPUT.PUT_LINE('Donor ID: ' || donor_rec.Donor_ID || 
                             ', Name: ' || donor_rec.Name || 
                             ', Blood Type: ' || donor_rec.Blood_Type ||
                             ', Blood Bank: ' || donor_rec.Bank_name); 
    END LOOP; 
END GetBloodTypeInformation;

--to execute

EXEC GetBloodTypeInformation('O-');

--2
--Procedure to update the Number of a manager

CREATE OR REPLACE PROCEDURE ManagerInformation( 
NewNumber BloodBank.Manager_Contact%TYPE ,
Bank_ID BloodBank. BloodBank_ID%TYPE )AS
BEGIN

UPDATE BloodBank SET Manager_Contact=NewNumber
WHERE BLOODBANK_ID= Bank_ID;
COMMIT;
END
ManagerInformation;

-- to execute

EXEC ManagerInformation ('508289479',2800);