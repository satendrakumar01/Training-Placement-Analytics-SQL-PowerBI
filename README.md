
# Training & Placement Performance Dashboard | SQL + Power BI

An end-to-end portfolio project that uses **MySQL** to store and analyse student training and placement data, and **Power BI** to present the results through an interactive dashboard.

> **Data note:** This project uses fictional/generated sample data for learning and portfolio demonstration. It is not confidential employer or NGO data, and dashboard findings should be treated as illustrative rather than real-world organizational conclusions.

## Dashboard Preview

![Training & Placement Performance Dashboard](screenshots/dashboard-overview.png)

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

## Repository Structure

```text
Training-Placement-Analytics-SQL-PowerBI/
├── README.md
├── screenshots/
│   └── dashboard-overview.png
└── sql/
    ├── 01_Create_Tables.sql
    ├── 02_Insert_Sample_Data.sql
    └── 03_Analysis_Queries.sql
```

Add your Power BI report file to the root before publishing, for example:

`Training_Placement_Performance_Dashboard.pbix`

## How to Run

1. Open `sql/01_Create_Tables.sql` in MySQL Workbench and execute it.
2. Execute `sql/02_Insert_Sample_Data.sql` **once on empty tables** to generate the 100 sample students and their linked training/placement records. The script requires MySQL 8.0+ for recursive CTE support.
3. Run queries from `sql/03_Analysis_Queries.sql` to explore the analysis.
4. Open the `.pbix` report in Power BI Desktop. To reproduce the SQL-connected version, connect to the `TrainingPlacementAnalytics` MySQL database and load the three tables.
5. Check the model relationships and confirm the KPI values and slicer interactions before sharing the report.

## Portfolio Considerations

- Validate KPIs against the SQL results before publishing screenshots.
- Keep sample-data status explicit; don't present synthetic results as actual organizational performance.
- Do not upload passwords, connection strings containing credentials, or confidential data.

## Skills Demonstrated

SQL table design, primary and foreign keys, joins, aggregation, conditional logic, business KPI design, Power BI data modeling, DAX measures, interactive reporting, dashboard layout, and data storytelling.
