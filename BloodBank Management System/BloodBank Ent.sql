--Blood Bank: Represents the organization that stores and manages blood with attributes like name, city, contact details, and manager information.

-- Table Creation code
create table BloodBank(
    BloodBank_ID NUMBER(13) ,
   Bank_Name VARCHAR2(20),
    City VARCHAR2(20),
    Contact NUMBER (13),
    Manager_Name VARCHAR2(20),
    Manager_Contact VARCHAR2(13),
    constraint  BloodBank_ID PRIMARY KEY ( BloodBank_ID) );

-- insertaion code :

Insert into BloodBank (BloodBank_ID,Bank_name, City ,contact  , Manager_name, Manager_contact) 
values (7022, 'Hapse', 'Akola', 5075938576, 'Ahmed', 507589476);

Insert into BloodBank (BloodBank_ID,Bank_name, City ,contact  , Manager_name, Manager_contact) 
values (2800, 'Sanjeevani', 'Akola', 502956938, 'Arpan', NULL);
Insert into BloodBank (BloodBank_ID,Bank_name, City ,contact  , Manager_name, Manager_contact) 
values (3390, 'Rotary', 'Beed', 506204792, 'Nirmal', 506396824);

Insert into BloodBank (BloodBank_ID,Bank_name, City ,contact  , Manager_name, Manager_contact) 
values (4980, 'Arpan', 'Ahmednagar', 507838204, 'Dr.Kharche', NULL);

Insert into BloodBank (BloodBank_ID,Bank_name, City ,contact  , Manager_name, Manager_contact) 
values (2309, 'Shakti', 'Ahmednagar', 504488559, 'Ankur', 506296835);
Insert into BloodBank (BloodBank_ID,Bank_name, City ,contact  , Manager_name, Manager_contact) 
values (3239, 'Shriram', 'Akola', 506699446, 'Sandraa', 507397128);

-- Checking 
select* from BloodBank;
