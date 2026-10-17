-- Training & Placement Analytics - sample data generation
-- MySQL 8.0+ recommended.
-- Run only once on empty tables. Uses fictional/generated sample data for portfolio use.

USE TrainingPlacementAnalytics;

-- 100 Students. Student IDs 1-100; admissions from 2026-06-01 onward.
INSERT INTO Students
    (Student_ID, Student_Name, Gender, District, Trade, Batch, Admission_Date)
WITH RECURSIVE nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM nums WHERE n < 100
)
SELECT
    n,
    CONCAT('Student ', n),
    IF(MOD(n, 2) = 0, 'Female', 'Male'),
    ELT(MOD(n - 1, 5) + 1,
        'Delhi', 'Gurugram', 'Noida', 'Ghaziabad', 'Faridabad'),
    ELT(MOD(n - 1, 4) + 1,
        'RSA', 'CSA', 'Electrical', 'SMO'),
    CONCAT(
        ELT(MOD(n - 1, 4) + 1,
            'RSA', 'CSA', 'Electrical', 'SMO'),
        '-B', FLOOR((n - 1) / 20) + 1
    ),
    DATE_ADD('2026-06-01', INTERVAL (n - 1) DAY)
FROM nums;

-- Training metrics generated deterministically for repeatable practice.
INSERT INTO Training_Performance
    (Student_ID, Attendance_Percentage, Assessment_Score, Trainer, Completion_Status)
SELECT
    Student_ID,
    ROUND(65 + MOD(Student_ID * 7, 31), 2),
    ROUND(55 + MOD(Student_ID * 11, 41), 2),
    CASE Trade
        WHEN 'RSA' THEN CASE WHEN MOD(Student_ID, 2) = 0 THEN 'Neha' ELSE 'Rohit' END
        WHEN 'CSA' THEN CASE WHEN MOD(Student_ID, 2) = 0 THEN 'Priya' ELSE 'Amit' END
        WHEN 'Electrical' THEN CASE WHEN MOD(Student_ID, 2) = 0 THEN 'Sanjay' ELSE 'Pooja' END
        WHEN 'SMO' THEN CASE WHEN MOD(Student_ID, 2) = 0 THEN 'Kavita' ELSE 'Rakesh' END
    END,
    CASE
        WHEN (65 + MOD(Student_ID * 7, 31)) < 70 THEN 'Dropped Out'
        ELSE 'Completed'
    END
FROM Students;

-- Placement records. Non-placed/ineligible records have no employer, salary or placement date.
INSERT INTO Placement
    (Student_ID, Placement_Status, Employer, Salary_Offered, Placement_Date)
SELECT
    s.Student_ID,
    CASE
        WHEN tp.Completion_Status = 'Dropped Out' THEN 'Not Eligible'
        WHEN MOD(s.Student_ID, 5) = 0 THEN 'Not Placed'
        ELSE 'Placed'
    END,
    CASE
        WHEN tp.Completion_Status = 'Dropped Out' OR MOD(s.Student_ID, 5) = 0 THEN NULL
        WHEN s.Trade = 'RSA' THEN CASE
            WHEN MOD(s.Student_ID, 3) = 0 THEN 'DMart'
            WHEN MOD(s.Student_ID, 3) = 1 THEN 'Reliance Retail'
            ELSE 'Flipkart' END
        WHEN s.Trade = 'CSA' THEN CASE
            WHEN MOD(s.Student_ID, 3) = 0 THEN 'Concentrix'
            WHEN MOD(s.Student_ID, 3) = 1 THEN 'Genpact'
            ELSE 'Teleperformance' END
        WHEN s.Trade = 'Electrical' THEN CASE
            WHEN MOD(s.Student_ID, 3) = 0 THEN 'Havells'
            WHEN MOD(s.Student_ID, 3) = 1 THEN 'Luminous'
            ELSE 'Crompton' END
        WHEN s.Trade = 'SMO' THEN CASE
            WHEN MOD(s.Student_ID, 3) = 0 THEN 'Raymond'
            WHEN MOD(s.Student_ID, 3) = 1 THEN 'Shahi Exports'
            ELSE 'Orient Craft' END
    END,
    CASE
        WHEN tp.Completion_Status = 'Dropped Out' OR MOD(s.Student_ID, 5) = 0 THEN NULL
        WHEN s.Trade = 'RSA' THEN 16000 + MOD(s.Student_ID * 37, 5001)
        WHEN s.Trade = 'CSA' THEN 17000 + MOD(s.Student_ID * 41, 6001)
        WHEN s.Trade = 'Electrical' THEN 18500 + MOD(s.Student_ID * 43, 7001)
        WHEN s.Trade = 'SMO' THEN 15000 + MOD(s.Student_ID * 31, 5001)
    END,
    CASE
        WHEN tp.Completion_Status = 'Dropped Out' OR MOD(s.Student_ID, 5) = 0 THEN NULL
        ELSE DATE_ADD(s.Admission_Date, INTERVAL (85 + MOD(s.Student_ID, 25)) DAY)
    END
FROM Students s
JOIN Training_Performance tp ON s.Student_ID = tp.Student_ID;

-- Validate row counts. Expected: 100 in each table.
SELECT COUNT(*) AS Student_Count FROM Students;
SELECT COUNT(*) AS Training_Count FROM Training_Performance;
SELECT COUNT(*) AS Placement_Count FROM Placement;
