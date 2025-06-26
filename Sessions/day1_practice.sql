-- Day 1 - SQL Query Work

-- View all tables in the 'public' schema
SELECT *
FROM information_schema.tables
WHERE table_schema = 'public';

-- Notes on default schema names:
-- PostgreSQL -> public
-- SQL Server -> dbo
-- Oracle/MySQL -> sys

-- Create employees table
CREATE TABLE employees (
    id INT,
    name VARCHAR(20),
    dept_id VARCHAR(10),
    salary FLOAT -- e.g., 2500.50
);

-- Drop employees table
DROP TABLE employees;

-- Rename employees table
ALTER TABLE employees RENAME TO employees_new;
ALTER TABLE employees_new RENAME TO employees;

-- Select from employees
SELECT * FROM employees;

-- Add new column
ALTER TABLE employees ADD COLUMN doj DATE;

-- Insert data with date conversion
INSERT INTO employees (id, name, dept_id, salary, doj)
VALUES (1, 'Sameer', 'D1', 3000, TO_DATE('2001-12-20', 'YYYY-MM-DD'));

/*
Example: data types
10 is an integer
'10' is a string
*/

-- Date conversion
SELECT TO_DATE('2001-12-20', 'YYYY-MM-DD');

-- Basic selects
SELECT 'sql';
SELECT 100;

-- Create department table
CREATE TABLE department (
    id INT,
    name VARCHAR(20)
);

-- Alter column type
ALTER TABLE department ALTER COLUMN id TYPE VARCHAR(10);

-- Insert data into department
INSERT INTO department VALUES ('D001', 'HR');

-- Sample inserts
INSERT INTO employees VALUES (1, 'Raj', 'D1', 4000);
INSERT INTO employees VALUES (1, 'Mohan', 'D2', 5000);
INSERT INTO employees VALUES (1, 'Kumar', 'D1', 0);
INSERT INTO employees VALUES (1, 'Raj', 'D1', 4000);

/*
Constraints overview:
Primary Key: Unique + Not Null
Unique: Unique, allows nulls
Check: Validates column values
Not Null: Does not allow nulls
Foreign Key: Creates relationship with another table
*/

-- Re-create department and employees with constraints
DROP TABLE employees;
DROP TABLE department;

CREATE TABLE department (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dept_id VARCHAR(10) REFERENCES department(id),
    salary FLOAT CHECK (salary > 0)
);

-- Insert sample data
INSERT INTO department VALUES ('D001', 'HR');
INSERT INTO employees VALUES (1, 'Raj', 'D001', 4000);
INSERT INTO employees VALUES (2, 'Mohan', 'D001', 5000);
INSERT INTO employees VALUES (3, 'Kumar', 'D001', 1);
INSERT INTO employees VALUES (4, 'Raj', 'D001', 4000);

-- Modify column
ALTER TABLE employees ADD COLUMN doj DATE;
ALTER TABLE employees DROP COLUMN doj;
ALTER TABLE employees ADD COLUMN doj DATE DEFAULT TO_DATE('2000-12-20', 'YYYY-MM-DD');

-- Using identity column
-- (alternative to manually inserting IDs)
-- CREATE TABLE employees (
--     id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     name VARCHAR(20) NOT NULL,
--     dept_id VARCHAR(10) REFERENCES department(id),
--     salary FLOAT CHECK (salary > 0)
-- );

ALTER TABLE employees ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (START WITH 50);
ALTER TABLE employees ALTER COLUMN id DROP IDENTITY;

-- Insert using default identity
INSERT INTO employees VALUES (DEFAULT, 'Hanan', 'D001', 4000);

SELECT * FROM employees;

-- Assignment: Healthcare Dataset

-- Create new database
CREATE DATABASE HealthcareDB;

-- Create tables with constraints
CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Date_Of_Birth DATE NOT NULL,
    Gender VARCHAR(50) NOT NULL,
    Phone VARCHAR(20)
);

CREATE TABLE Doctors (
    Doctor_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    Phone VARCHAR(20)
);

CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Appointment_Date TIMESTAMP NOT NULL,
    Reason VARCHAR(255),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE Prescriptions (
    Prescription_ID INT PRIMARY KEY,
    Appointment_ID INT NOT NULL,
    Medication VARCHAR(255) NOT NULL,
    Dosage VARCHAR(100) NOT NULL,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

-- Insert sample records
INSERT INTO Patients VALUES
(1, 'John', 'Doe', '1985-04-12', 'Male', '123-456-7890'),
(2, 'Jane', 'Smith', '1990-08-25', 'Female', '234-567-8901'),
(3, 'Michael', 'Brown', '1975-12-30', 'Male', '345-678-9012'),
(4, 'Emily', 'Clark', '2000-03-18', 'Female', '456-789-0123'),
(5, 'David', 'Wilson', '1982-11-05', 'Male', '567-890-1234');

INSERT INTO Doctors VALUES
(1, 'Dr. Alice', 'Johnson', 'Cardiology', '678-901-2345'),
(2, 'Dr. Bob', 'Williams', 'Neurology', '789-012-3456'),
(3, 'Dr. Carol', 'Jones', 'Pediatrics', '890-123-4567'),
(4, 'Dr. Dan', 'Garcia', 'Orthopedics', '901-234-5678'),
(5, 'Dr. Eve', 'Martinez', 'Dermatology', '012-345-6789');

INSERT INTO Appointments VALUES
(5001, 1, 1, '2023-10-01 10:00:00', 'Routine Checkup'),
(5002, 2, 2, '2023-10-02 11:30:00', 'Headache'),
(5003, 3, 3, '2023-10-03 14:15:00', 'Pediatric Consultation'),
(5004, 4, 4, '2023-10-04 09:45:00', 'Orthopedic Issue'),
(5006, 5, 5, '2023-10-05 13:00:00', 'Skin Rash');

INSERT INTO Prescriptions VALUES
(151, 5001, 'Aspirin', '100mg'),
(456, 5002, 'Ibuprofen', '200mg'),
(7849, 5003, 'Amoxicillin', '500mg'),
(4356, 5004, 'Corticosteroid Cream', 'Apply twice daily'),
(24686, 5006, 'Antihistamine', '10mg');

-- Verify data
SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;
SELECT * FROM Prescriptions;