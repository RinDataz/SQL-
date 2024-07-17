-- Query to find Donors' ids where the blood bank they donated in is located in 'Akola'

Select Donor_ID , Name 
from Donor 
where BloodBank_ID in(SELECT BloodBank_id
    					FROM BloodBank
                				WHERE City ='Akola');

-- find the blood's Type, Amount and Availablety by joining three tables
SELECT 
      Donor.Blood_Type,
      Donation_Process.Amount_donated,
      Blood_Bag.Available
      FROM Donation_Process
      JOIN Donor 
      ON  Donation_Process.Donor_ID =Donor.Donor_ID
     JOIN Blood_Bag
     ON Blood_Bag.Donation_ID = Donation_Process.Donation_ID
     ORDER BY Donor.Donor_ID;

-- Count the amount of patients from each Sex

Select COUNT (Patient_ID) as Patients, Gender
From Patient
GROUP BY Gender;

-- count the total donated amounts from each donor 

Select count(BloodBag_ID)as Amount_Donated,Donation_ID as Doner
From Blood_Bag
Group by Donation_ID;

-- to show the blood bank's id and manager contact in the city 'Ahmednagar'

Select BloodBank_ID , Manager_Contact  From BloodBank
Where City = 'Ahmednagar';

