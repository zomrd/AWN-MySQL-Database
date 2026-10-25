-- Synthetic demo data; not real student or employee records.
-- Run once, after 01_schema.sql.

USE awn_portfolio;

START TRANSACTION;

-- 1. Academic advisors
INSERT INTO Employee
    (Emp_ID, FNameE, LNameE, Admin_Email)
VALUES
    ('E001', 'Advisor', 'One', 'advisor1@example.com'),
    ('E002', 'Advisor', 'Two', 'advisor2@example.com'),
    ('E003', 'Advisor', 'Three', 'advisor3@example.com');

-- 2. Students
INSERT INTO Student
    (Stu_ID, FnameS, LnameS, Email_S, Date_of_Birth, Advisor_ID)
VALUES
    ('S001', 'Student', 'One', 'student1@example.com', '2002-01-10', 'E001'),
    ('S002', 'Student', 'Two', 'student2@example.com', '2002-03-15', 'E001'),
    ('S003', 'Student', 'Three', 'student3@example.com', '2003-05-20', 'E001'),
    ('S004', 'Student', 'Four', 'student4@example.com', '2002-07-12', 'E002'),
    ('S005', 'Student', 'Five', 'student5@example.com', '2003-09-18', 'E002'),
    ('S006', 'Student', 'Six', 'student6@example.com', '2002-11-25', 'E003'),
    ('S007', 'Student', 'Seven', 'student7@example.com', '2003-02-08', 'E003'),
    ('S008', 'Student', 'Eight', 'student8@example.com', '2002-06-14', NULL);

-- 3. Service categories
INSERT INTO Appointment (Services_ID, Services_Name)
VALUES
    (1, 'Office Hours'),
    (2, 'Peer Education'),
    (3, 'Community Partnership'),
    (4, 'Part-Time Jobs'),
    (5, 'Entertainment');

-- 4. Courses
INSERT INTO Course (Course_ID, Course_Name)
VALUES
    ('CS-115', 'Introduction to Programming'),
    ('CS-150', 'Computer Science I'),
    ('CS-240', 'Digital Logic'),
    ('CS-350', 'Database Systems');

-- 5. Registrations for service categories
-- These represent category interest, not individual bookings.
INSERT INTO Book (Stu_ID, Services_ID)
VALUES
    ('S001', 1), ('S001', 2), ('S001', 3),
    ('S002', 1), ('S002', 3),
    ('S003', 2), ('S003', 4),
    ('S004', 1), ('S004', 3), ('S004', 5),
    ('S005', 3), ('S005', 4),
    ('S006', 2), ('S006', 5),
    ('S007', 3);

-- 6. Office hours
INSERT INTO OfficeHours
    (Emp_ID, Course_ID, Session_Date, Start_Time, End_Time)
VALUES
    ('E001', 'CS-115', '2026-09-07', '09:00:00', '10:00:00'),
    ('E002', 'CS-150', '2026-09-08', '10:00:00', '11:00:00'),
    ('E003', 'CS-240', '2026-09-09', '11:00:00', '12:00:00'),
    ('E001', 'CS-350', '2026-09-10', '13:00:00', '14:00:00');

-- 7. Peer education
INSERT INTO PeerEducation
    (Tutor_ID, Course_ID, Session_Date, Start_Time, End_Time)
VALUES
    ('S001', 'CS-115', '2026-09-14', '10:00:00', '11:00:00'),
    ('S003', 'CS-150', '2026-09-15', '11:00:00', '12:00:00'),
    ('S006', 'CS-350', '2026-09-16', '13:00:00', '14:30:00');

-- 8. Fictional partnership activities
-- Prices are illustrative amounts in SAR.
INSERT INTO CommunityPartnership
    (Provider_Name, Activity_Type, Activity_Title,
     Price, Activity_Date, City)
VALUES
    ('Demo Academy', 'Course', 'SQL Fundamentals',
     150.00, '2026-09-20', 'Qatif'),
    ('Demo Academy', 'Workshop', 'Power BI Basics',
     100.00, '2026-09-22', 'Dammam'),
    ('Sample Learning', 'Course', 'Python for Data Analysis',
     250.00, '2026-10-01', 'Khobar'),
    ('Sample Learning', 'Workshop', 'Data Cleaning',
     120.00, '2026-10-03', 'Qatif'),
    ('Practice Center', 'Course', 'Database Design',
     200.00, '2026-10-05', 'Dammam'),
    ('Practice Center', 'Workshop', 'Career Preparation',
     0.00, '2026-10-07', 'Khobar');

-- 9. Fictional part-time opportunities
-- Monthly salaries are illustrative amounts in SAR.
INSERT INTO PartTimeJob
    (Job_Name, City, Start_Date, End_Date,
     Daily_Work_Hours, Monthly_Salary)
VALUES
    ('Library Assistant', 'Qatif',
     '2026-09-01', '2026-12-31', 3.00, 1500.00),
    ('Lab Assistant', 'Dammam',
     '2026-09-01', '2026-12-31', 4.00, 2200.00),
    ('Data Entry Assistant', 'Khobar',
     '2026-09-01', '2026-12-31', 4.00, 2400.00),
    ('Programming Tutor', 'Qatif',
     '2026-10-01', '2026-12-31', 3.00, 2000.00),
    ('Registration Assistant', 'Dammam',
     '2026-10-01', '2026-12-31', 5.00, 2800.00);

-- 10. Fictional entertainment trips
INSERT INTO Entertainment
    (Trip_Name, Trip_Date, Trip_Type, Price)
VALUES
    ('Campus Activity Day', '2026-09-25', 'Internal', 0.00),
    ('Museum Visit', '2026-10-02', 'External', 25.00),
    ('Book Fair Visit', '2026-10-09', 'External', 30.00),
    ('Science Center Visit', '2026-10-16', 'External', 45.00);

COMMIT;
