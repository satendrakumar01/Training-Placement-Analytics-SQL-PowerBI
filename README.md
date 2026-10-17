
# Training & Placement Performance Dashboard | SQL + Power BI

An end-to-end portfolio project that uses **MySQL** to store and analyse student training and placement data, and **Power BI** to present the results through an interactive dashboard.

> **Data note:** This project uses fictional/generated sample data for learning and portfolio demonstration. It is not confidential employer or NGO data, and dashboard findings should be treated as illustrative rather than real-world organizational conclusions.

## Dashboard Preview

![Training & Placement Performance Dashboard]([screenshots/dashboard-overview.png](https://github.com/satendrakumar01/Training-Placement-Analytics-SQL-PowerBI/blob/main/TRAINING%20%26%20PLACEMENT%20PERFORMANCE%20DASHBOARD.png))


<img width="836" height="688" alt="image" src="https://github.com/user-attachments/assets/74c76fce-60ee-498d-8236-ec842065ef20" />


## Business Objective

Build an interactive view of student admissions, training participation, assessment performance, course completion, placement outcomes, and placement salaries. The report is designed to help a viewer compare outcomes by trade, district, trainer, batch, gender, and placement status.

## Tools & Technologies

- **MySQL** — database schema, relational tables, data setup, and business analysis queries
- **Power BI Desktop** — data model, DAX measures, visuals, interactive slicers, and report layout
- **Power Query** — data connection and transformation
- **DAX** — KPI calculations and analytical measures

## Database Design

The database is named `TrainingPlacementAnalytics` and contains three tables:

| Table | Purpose | Key fields |
|---|---|---|
| `Students` | Student profile and admission details | `Student_ID`, `Gender`, `District`, `Trade`, `Batch`, `Admission_Date` |
| `Training_Performance` | Attendance, assessment, trainer, and completion | `Student_ID`, `Attendance_Percentage`, `Assessment_Score`, `Trainer`, `Completion_Status` |
| `Placement` | Placement status, employer, salary, and placement date | `Student_ID`, `Placement_Status`, `Employer`, `Salary_Offered`, `Placement_Date` |

`Student_ID` is the primary key in `Students` and is referenced by the two performance/outcome tables. Each student has one corresponding training record and one placement-status record in this sample model.

## Dashboard Features

### KPI cards
- Total Students
- Placed Students
- Placement Rate
- Average Attendance
- Average Assessment Score
- Average Placement Salary

### Interactive slicers
- Trade
- District
- Gender
- Trainer
- Batch
- Admission Month
- Placement Status

### Visual analysis
- Student count by trade
- Placed students by trade
- Placement status distribution
- Student count by district
- Average assessment score by trainer
- Average salary by employer
- Monthly admissions and placements
- Attendance versus assessment score

## SQL Analysis Included

The SQL scripts include queries for:

- Overall student and placement KPIs
- Trade-wise placement and training performance
- District-wise placement performance
- Trainer performance
- Employer-wise placement salary
- Placement and completion status distributions
- Attendance categorization
- Average salary by trade
- Monthly admissions
- Student-level detail and data-quality validation
```




## Skills Demonstrated

SQL table design, primary and foreign keys, joins, aggregation, conditional logic, business KPI design, Power BI data modeling, DAX measures, interactive reporting, dashboard layout, and data storytelling.
