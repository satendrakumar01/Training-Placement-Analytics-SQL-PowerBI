-- Training & Placement Analytics: SQL business analysis queries
USE TrainingPlacementAnalytics;

-- Q1. Overall KPIs
SELECT
    COUNT(DISTINCT s.Student_ID) AS Total_Students,
    COUNT(DISTINCT CASE WHEN p.Placement_Status = 'Placed' THEN s.Student_ID END) AS Placed_Students,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN p.Placement_Status = 'Placed' THEN s.Student_ID END)
          / NULLIF(COUNT(DISTINCT s.Student_ID), 0), 2) AS Placement_Rate_Percent,
    ROUND(AVG(tp.Attendance_Percentage), 2) AS Avg_Attendance_Percent,
    ROUND(AVG(tp.Assessment_Score), 2) AS Avg_Assessment_Score,
    ROUND(AVG(CASE WHEN p.Placement_Status = 'Placed' THEN p.Salary_Offered END), 2) AS Avg_Placement_Salary
FROM Students s
LEFT JOIN Training_Performance tp ON s.Student_ID = tp.Student_ID
LEFT JOIN Placement p ON s.Student_ID = p.Student_ID;

-- Q2. Trade-wise placement and training performance
SELECT
    s.Trade,
    COUNT(*) AS Total_Students,
    SUM(CASE WHEN p.Placement_Status = 'Placed' THEN 1 ELSE 0 END) AS Placed_Students,
    ROUND(100.0 * SUM(CASE WHEN p.Placement_Status = 'Placed' THEN 1 ELSE 0 END)
          / NULLIF(COUNT(*), 0), 2) AS Placement_Rate_Percent,
    ROUND(AVG(tp.Attendance_Percentage), 2) AS Avg_Attendance,
    ROUND(AVG(tp.Assessment_Score), 2) AS Avg_Assessment_Score
FROM Students s
LEFT JOIN Training_Performance tp ON s.Student_ID = tp.Student_ID
LEFT JOIN Placement p ON s.Student_ID = p.Student_ID
GROUP BY s.Trade
ORDER BY Placement_Rate_Percent DESC;

-- Q3. District-wise placement performance
SELECT
    s.District,
    COUNT(*) AS Total_Students,
    SUM(CASE WHEN p.Placement_Status = 'Placed' THEN 1 ELSE 0 END) AS Placed_Students,
    ROUND(100.0 * SUM(CASE WHEN p.Placement_Status = 'Placed' THEN 1 ELSE 0 END)
          / NULLIF(COUNT(*), 0), 2) AS Placement_Rate_Percent
FROM Students s
LEFT JOIN Placement p ON s.Student_ID = p.Student_ID
GROUP BY s.District
ORDER BY Placement_Rate_Percent DESC;

-- Q4. Trainer performance
SELECT
    tp.Trainer,
    COUNT(*) AS Students_Trained,
    ROUND(AVG(tp.Attendance_Percentage), 2) AS Avg_Attendance,
    ROUND(AVG(tp.Assessment_Score), 2) AS Avg_Assessment_Score,
    SUM(CASE WHEN p.Placement_Status = 'Placed' THEN 1 ELSE 0 END) AS Placed_Students
FROM Training_Performance tp
LEFT JOIN Placement p ON tp.Student_ID = p.Student_ID
GROUP BY tp.Trainer
ORDER BY Avg_Assessment_Score DESC;

-- Q5. Employer-wise placed student and salary analysis
SELECT
    p.Employer,
    COUNT(*) AS Placed_Students,
    ROUND(AVG(p.Salary_Offered), 2) AS Avg_Salary_Offered,
    MAX(p.Salary_Offered) AS Highest_Salary_Offered
FROM Placement p
WHERE p.Placement_Status = 'Placed'
GROUP BY p.Employer
ORDER BY Avg_Salary_Offered DESC;

-- Q6. Placement status distribution
SELECT Placement_Status, COUNT(*) AS Students
FROM Placement
GROUP BY Placement_Status
ORDER BY Students DESC;

-- Q7. Training completion distribution
SELECT Completion_Status, COUNT(*) AS Students
FROM Training_Performance
GROUP BY Completion_Status;

-- Q8. Attendance categories
SELECT
    CASE
        WHEN Attendance_Percentage < 70 THEN 'Low (<70%)'
        WHEN Attendance_Percentage < 85 THEN 'Medium (70-84.99%)'
        ELSE 'High (>=85%)'
    END AS Attendance_Category,
    COUNT(*) AS Students
FROM Training_Performance
GROUP BY Attendance_Category
ORDER BY Students DESC;

-- Q9. Average placement salary by trade (placed students only)
SELECT
    s.Trade,
    COUNT(*) AS Placed_Students,
    ROUND(AVG(p.Salary_Offered), 2) AS Avg_Placement_Salary
FROM Students s
JOIN Placement p ON s.Student_ID = p.Student_ID
WHERE p.Placement_Status = 'Placed'
GROUP BY s.Trade
ORDER BY Avg_Placement_Salary DESC;

-- Q10. Monthly admissions
SELECT
    DATE_FORMAT(Admission_Date, '%Y-%m') AS Admission_Month,
    COUNT(*) AS Admissions
FROM Students
GROUP BY DATE_FORMAT(Admission_Date, '%Y-%m')
ORDER BY Admission_Month;

-- Q11. Student-level detail for drill-through/validation
SELECT
    s.Student_ID,
    s.Student_Name,
    s.Gender,
    s.District,
    s.Trade,
    s.Batch,
    s.Admission_Date,
    tp.Attendance_Percentage,
    tp.Assessment_Score,
    tp.Trainer,
    tp.Completion_Status,
    p.Placement_Status,
    p.Employer,
    p.Salary_Offered,
    p.Placement_Date
FROM Students s
LEFT JOIN Training_Performance tp ON s.Student_ID = tp.Student_ID
LEFT JOIN Placement p ON s.Student_ID = p.Student_ID
ORDER BY s.Student_ID;

-- Q12. Sanity check: count of students with a placement record but no salary (expected for not placed/not eligible)
SELECT Placement_Status, COUNT(*) AS Students, SUM(Salary_Offered IS NULL) AS Missing_Salary_Rows
FROM Placement
GROUP BY Placement_Status;
