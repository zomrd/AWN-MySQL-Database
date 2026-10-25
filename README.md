# AWN — University Student Services Database

A MySQL portfolio project demonstrating relational database design,
data integrity, analytical SQL, reporting views, stored routines,
and salary change auditing.

## Project Background

AWN originated as a university student services project with a Java
application and a MySQL database.

This repository presents a revised database-focused edition for a
data portfolio. It includes redesigned relationships, synthetic sample
data, and additional analytical queries. Some table and column names
differ from the original application, so the original Java code
requires changes to work with this edition.

## Services Covered

- Academic office hours
- Peer education
- Community partnership courses and workshops
- Part-time job opportunities
- Entertainment trips

## Tools and Skills

- MySQL 8.0.16 or later
- Relational database design
- Primary keys, foreign keys, and CHECK constraints
- JOINs, aggregation, and subqueries
- Common Table Expressions (CTEs)
- Window functions: DENSE_RANK
- Reporting views
- Stored procedures and functions
- Triggers and audit tables
- Transactions

## Repository Structure

```text
sql/
  01_schema.sql
  02_sample_data.sql
  03_analysis_queries.sql
  04_views.sql
  05_routines.sql
  06_triggers.sql
```

## Database Design

The schema contains ten core tables and one audit table.

| Table | Purpose |
| --- | --- |
| Employee | Academic advisors |
| Student | Students and advisor assignments |
| Appointment | Service category catalog |
| Book | Student registrations for service categories |
| Course | Academic courses |
| OfficeHours | Offered office-hour sessions |
| PeerEducation | Offered student-led sessions |
| CommunityPartnership | Courses and workshops |
| PartTimeJob | Advertised part-time opportunities |
| Entertainment | Offered trips |
| JobSalaryAudit | History of salary changes |

The `Book` table connects students to service categories.
It does not record bookings for individual sessions, jobs, or trips.

## Analytical Questions

1. Which service categories have the most registrations?
2. What percentage of students registered for each category?
3. Which students have not registered for any category?
4. How many students are assigned to each advisor?
5. How do activity prices differ by city?
6. What is the cheapest activity in each city, including ties?
7. How do advertised monthly salaries differ by city?
8. Which jobs offer salaries above the overall average?
9. How many office-hour sessions are offered per course?
10. How do free and paid trips compare?

## Reporting Views

- `vw_service_registrations`
- `vw_activity_prices_by_city`
- `vw_job_salaries_by_city`

## Stored Routines

- `GetStudentsByAdvisor`: returns students assigned to an advisor.
- `CalculateDiscountedPrice`: calculates a price after a percentage
  discount without changing the original data.

## Audit Trigger

`trg_job_salary_audit` records the old salary, new salary, job ID,
and timestamp whenever an advertised monthly salary changes.

An optional transaction-based test is included in `06_triggers.sql`.
It uses ROLLBACK to undo the test changes.

## How to Run

Use MySQL 8.0.16 or later with MySQL Workbench or the mysql client.

1. Run `01_schema.sql` to create the `awn_portfolio` database and tables.
2. Run `02_sample_data.sql` once to insert the synthetic data.
3. Run `03_analysis_queries.sql` to explore the data.
4. Run `04_views.sql` to create reporting views.
5. Run `05_routines.sql` to create and demonstrate stored routines.
6. Run `06_triggers.sql` to create the audit table and trigger.

Start with a new, empty `awn_portfolio` database.
The schema and sample data scripts are intended for initial setup,
not repeated execution against populated tables.

Creating databases, routines, and triggers requires appropriate
MySQL permissions.

## Data and Interpretation

- All supplied sample records are synthetic.
- Prices and monthly salaries are illustrative amounts in SAR.
- Category registrations represent interest, not actual attendance.
- Students can register for multiple categories, so category
  percentages may sum to more than 100%.
- Activity price averages include free activities.
- The sample is small and intended to demonstrate SQL techniques.
- Results should not be interpreted as real university or market data.

## Validation Status

All six SQL scripts were executed successfully in MySQL Workbench.

Verified:
- Creation of the database and ten core tables.
- Insertion of synthetic sample data.
- Execution of all ten analytical queries.
- Creation and querying of three reporting views.
- Execution of the advisor procedure and discount function.
- Salary audit trigger: an update generated an audit record,
  and ROLLBACK removed the test record.

This validation covers script execution and the demonstrated
examples, rather than exhaustive testing of every constraint
and input.

## References

- [MySQL Documentation](https://dev.mysql.com/doc/refman/8.4/en/)
- [Foreign Keys](https://dev.mysql.com/doc/refman/8.4/en/create-table-foreign-keys.html)
- [Window Functions](https://dev.mysql.com/doc/refman/8.4/en/window-functions.html)
- [Triggers](https://dev.mysql.com/doc/refman/8.4/en/trigger-syntax.html)
