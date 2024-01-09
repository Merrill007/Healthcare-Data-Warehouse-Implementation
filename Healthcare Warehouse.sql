-- Create Database
CREATE DATABASE HealthcareDataWarehouse;
GO

-- Use the Database
USE HealthcareDataWarehouse;
GO

-- Create Patient Information Table
CREATE TABLE PatientInformation (
    PatientID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender NVARCHAR(10),
    ContactInformation NVARCHAR(100),
    CONSTRAINT CK_Gender CHECK (Gender IN ('Male', 'Female', 'Other'))
);

-- Create Medical History Table
CREATE TABLE MedicalHistory (
    MedicalHistoryID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES PatientInformation(PatientID),
    Allergies NVARCHAR(255),
    PastIllnesses NVARCHAR(255),
    Surgeries NVARCHAR(255),
    FamilyMedicalHistory NVARCHAR(255)
);

-- Create Diagnoses Table
CREATE TABLE Diagnoses (
    DiagnosisID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES PatientInformation(PatientID),
    DateOfDiagnosis DATE,
    DiagnosisDescription NVARCHAR(255),
    TreatingPhysician NVARCHAR(100)
);

-- Create Treatments Table
CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES PatientInformation(PatientID),
    DiagnosisID INT FOREIGN KEY REFERENCES Diagnoses(DiagnosisID),
    TreatmentDate DATE,
    MedicationsPrescribed NVARCHAR(255),
    ProceduresPerformed NVARCHAR(255)
);

-- Create Billing Information Table
CREATE TABLE BillingInformation (
    BillID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES PatientInformation(PatientID),
    DateOfService DATE,
    ProcedureCodes NVARCHAR(50),
    InsuranceInformation NVARCHAR(255),
    AmountBilled DECIMAL(10, 2),
    CONSTRAINT CK_AmountBilled CHECK (AmountBilled >= 0)
);

-- Create Appointment Scheduling Table
CREATE TABLE AppointmentScheduling (
    AppointmentID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES PatientInformation(PatientID),
    AppointmentDateTime DATETIME,
    AssignedPhysician NVARCHAR(100),
    AppointmentType NVARCHAR(50),
    CONSTRAINT CK_AppointmentType CHECK (AppointmentType IN ('Routine Check-up', 'Follow-up'))
);

-- Indexes for Performance Optimization
CREATE INDEX IX_PatientInformation_LastName ON PatientInformation(LastName);
CREATE INDEX IX_Diagnoses_DateOfDiagnosis ON Diagnoses(DateOfDiagnosis);
CREATE INDEX IX_Treatments_TreatmentDate ON Treatments(TreatmentDate);
CREATE INDEX IX_BillingInformation_DateOfService ON BillingInformation(DateOfService);
CREATE INDEX IX_AppointmentScheduling_AppointmentDateTime ON AppointmentScheduling(AppointmentDateTime);

-- Insert Sample Values into PatientInformation Table
INSERT INTO PatientInformation VALUES
(1, 'John', 'Doe', '1990-05-15', 'Male', '123 Main St, Cityville'),
(2, 'Jane', 'Smith', '1985-08-22', 'Female', '456 Oak St, Townsville'),
(3, 'Alice', 'Johnson', '1972-12-03', 'Female', '789 Pine St, Villagetown'),
(4, 'Bob', 'Williams', '1988-07-19', 'Male', '101 Cedar St, Hamletsville'),
(5, 'Emily', 'Davis', '1995-03-28', 'Female', '222 Maple St, Riverside'),
(6, 'Michael', 'Brown', '1979-09-10', 'Male', '333 Elm St, Hillside'),
(7, 'Sophia', 'Miller', '1965-02-14', 'Female', '444 Birch St, Lakeside'),
(8, 'David', 'Jones', '1993-11-07', 'Male', '555 Oak St, Countryside'),
(9, 'Olivia', 'Clark', '1980-06-25', 'Female', '666 Cedar St, Summitville'),
(10, 'Daniel', 'Taylor', '1970-04-18', 'Male', '777 Pine St, Brookside');

-- Insert Sample Values into MedicalHistory Table
INSERT INTO MedicalHistory VALUES
(1, 1, 'Pollen', 'None', 'Appendectomy in 2008', 'Heart disease in family'),
(2, 2, 'Penicillin', 'Asthma', 'None', 'Diabetes in family'),
(3, 3, 'Dust', 'Migraines', 'Gallbladder removal in 2015', 'Cancer in family'),
(4, 4, 'Mold', 'Hypothyroidism', 'Knee surgery in 2012', 'None'),
(5, 5, 'Pet Dander', 'None', 'None', 'High cholesterol in family'),
(6, 6, 'Shellfish', 'Seasonal allergies', 'None', 'None'),
(7, 7, 'Peanuts', 'None', 'None', 'Alzheimers in family'),
(8, 8, 'Latex', 'None', 'None', 'None'),
(9, 9, 'Soy', 'Migraines', 'Appendectomy in 1998', 'Diabetes in family'),
(10, 10, 'Eggs', 'None', 'None', 'None');

-- Insert Sample Values into Diagnoses Table
INSERT INTO Diagnoses (DiagnosisID, PatientID, DateOfDiagnosis, DiagnosisDescription, TreatingPhysician)
VALUES
(1, 1, '2022-01-05', 'Respiratory Infection', 'Dr. Johnson'),
(2, 2, '2021-11-10', 'Hypertension', 'Dr. Anderson'),
(3, 3, '2022-02-15', 'Allergic Rhinitis', 'Dr. White'),
(4, 4, '2022-01-20', 'Hypothyroidism', 'Dr. Martinez'),
(5, 5, '2022-03-10', 'Migraine', 'Dr. Davis'),
(6, 6, '2022-02-10', 'Food Allergy', 'Dr. Adams'),
(7, 7, '2022-01-15', 'Peanut Allergy', 'Dr. Turner'),
(8, 8, '2022-03-01', 'Latex Allergy', 'Dr. Harris'),
(9, 9, '2021-11-20', 'Gastroesophageal Reflux Disease', 'Dr. Rodriguez'),
(10, 10, '2022-02-20', 'Egg Allergy', 'Dr. Hall');

-- Insert Sample Values into Treatments Table
INSERT INTO Treatments (TreatmentID, PatientID, DiagnosisID, TreatmentDate, MedicationsPrescribed, ProceduresPerformed)
VALUES
(1, 1, 1, '2022-01-10', 'Antibiotics', 'None'),
(2, 2, 2, '2021-12-01', 'Anti-hypertensive medication', 'None'),
(3, 3, 3, '2022-02-05', 'Antihistamines', 'None'),
(4, 4, 4, '2021-11-05', 'Levothyroxine', 'Physical therapy for knee'),
(5, 5, 5, '2022-01-20', 'Sumatriptan', 'Lifestyle modifications'),
(6, 6, 6, '2021-12-10', 'Epinephrine auto-injector', 'Avoidance of allergens'),
(7, 7, 7, '2022-02-01', 'Epinephrine auto-injector', 'Avoidance of peanuts'),
(8, 8, 8, '2022-01-15', 'Avoidance of latex', 'None'),
(9, 9, 9, '2021-11-20', 'Proton pump inhibitors', 'None'),
(10, 10, 10, '2022-02-10', 'Avoidance of eggs', 'None');


-- Insert Sample Values into BillingInformation Table
INSERT INTO BillingInformation VALUES
(1, 1, '2022-01-10', 'CPT123', 'Insurance Company A', 150.00),
(2, 2, '2021-12-01', 'CPT456', 'Insurance Company B', 200.00),
(3, 3, '2022-02-15', 'CPT789', 'Insurance Company C', 120.00),
(4, 4, '2021-11-05', 'CPT101', 'Insurance Company A', 180.00),
(5, 5, '2022-01-20', 'CPT222', 'Insurance Company B', 250.00),
(6, 6, '2021-12-10', 'CPT333', 'Insurance Company C', 90.00),
(7, 7, '2022-02-05', 'CPT444', 'Insurance Company A', 200.00),
(8, 8, '2022-01-15', 'CPT555', 'Insurance Company B', 170.00),
(9, 9, '2021-11-20', 'CPT666', 'Insurance Company C', 120.00),
(10, 10, '2022-02-10', 'CPT777', 'Insurance Company A', 220.00);

-- Insert Sample Values into AppointmentScheduling Table
INSERT INTO AppointmentScheduling VALUES
(1, 1, '2022-02-01 09:00:00', 'Dr. Smith', 'Routine Check-up'),
(2, 2, '2022-02-15 14:30:00', 'Dr. Brown', 'Follow-up'),
(3, 3, '2022-03-05 10:45:00', 'Dr. Taylor', 'Follow-up'),
(4, 4, '2022-01-20 11:30:00', 'Dr. Martinez', 'Routine Check-up'),
(5, 5, '2022-03-10 15:15:00', 'Dr. Harris', 'Follow-up'),
(6, 6, '2022-02-10 13:00:00', 'Dr. Turner', 'Routine Check-up'),
(7, 7, '2022-01-15 08:30:00', 'Dr. Rodriguez', 'Routine Check-up'),
(8, 8, '2022-03-01 12:00:00', 'Dr. Adams', 'Routine Check-up'),
(9, 9, '2022-01-25 09:45:00', 'Dr. White', 'Follow-up'),
(10, 10, '2022-02-20 14:00:00', 'Dr. Hall', 'Routine Check-up');

SELECT *
FROM AppointmentScheduling;

SELECT *
FROM BillingInformation;

SELECT *
FROM Diagnoses;

SELECT *
FROM MedicalHistory;

SELECT *
FROM PatientInformation;

SELECT *
FROM Treatments;


