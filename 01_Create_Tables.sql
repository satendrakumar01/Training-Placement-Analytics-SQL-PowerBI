-- Training & Placement Analytics
-- MySQL schema for a fictional sample portfolio project.
-- Run this script first.

CREATE DATABASE IF NOT EXISTS TrainingPlacementAnalytics;
USE TrainingPlacementAnalytics;

CREATE TABLE IF NOT EXISTS Students (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(20),
    District VARCHAR(50),
    Trade VARCHAR(50),
    Batch VARCHAR(20),
    Admission_Date DATE
);

CREATE TABLE IF NOT EXISTS Training_Performance (
    Student_ID INT PRIMARY KEY,
    Attendance_Percentage DECIMAL(5,2),
    Assessment_Score DECIMAL(5,2),
    Trainer VARCHAR(100),
    Completion_Status VARCHAR(30),
    CONSTRAINT fk_training_student
        FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID)
);

CREATE TABLE IF NOT EXISTS Placement (
    Student_ID INT PRIMARY KEY,
    Placement_Status VARCHAR(30),
    Employer VARCHAR(100),
    Salary_Offered DECIMAL(10,2),
    Placement_Date DATE,
    CONSTRAINT fk_placement_student
        FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID)
);

-- Expected model: Students is the parent table; Training_Performance and Placement
-- each have one row per student and reference Students.Student_ID.

SHOW TABLES;
DESCRIBE Students;
DESCRIBE Training_Performance;
DESCRIBE Placement;
