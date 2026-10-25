USE awn_portfolio;

-- 1. Which service categories have the most registrations?
-- Registrations indicate category interest, not attendance.
SELECT
    a.Services_Name,
    COUNT(b.Stu_ID) AS Registered_Students
FROM Appointment AS a
LEFT JOIN Book AS b
    ON a.Services_ID = b.Services_ID
GROUP BY a.Services_ID, a.Services_Name
ORDER BY Registered_Students DESC, a.Services_Name;


-- 2. What percentage of students registered for each category?
-- A student can register for multiple categories.
SELECT
    a.Services_Name,
    COUNT(b.Stu_ID) AS Registered_Students,
    ROUND(
        100.0 * COUNT(b.Stu_ID) /
        NULLIF((SELECT COUNT(*) FROM Student), 0),
        2
    ) AS Student_Percentage
FROM Appointment AS a
LEFT JOIN Book AS b
    ON a.Services_ID = b.Services_ID
GROUP BY a.Services_ID, a.Services_Name
ORDER BY Student_Percentage DESC, a.Services_Name;


-- 3. Which students have not registered for any service category?
SELECT
    s.Stu_ID,
    s.FnameS,
    s.LnameS
FROM Student AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM Book AS b
    WHERE b.Stu_ID = s.Stu_ID
)
ORDER BY s.Stu_ID;


-- 4. How many students are assigned to each advisor?
SELECT
    e.Emp_ID,
    CONCAT(e.FNameE, ' ', e.LNameE) AS Advisor_Name,
    COUNT(s.Stu_ID) AS Assigned_Students
FROM Employee AS e
LEFT JOIN Student AS s
    ON e.Emp_ID = s.Advisor_ID
GROUP BY e.Emp_ID, e.FNameE, e.LNameE
ORDER BY Assigned_Students DESC, e.Emp_ID;


-- 5. How do partnership activity prices differ by city?
-- Prices include free activities and are expressed in SAR.
SELECT
    City,
    COUNT(*) AS Activity_Count,
    ROUND(AVG(Price), 2) AS Average_Price_SAR,
    MIN(Price) AS Minimum_Price_SAR,
    MAX(Price) AS Maximum_Price_SAR
FROM CommunityPartnership
GROUP BY City
ORDER BY Average_Price_SAR DESC, City;


-- 6. What is the cheapest activity in each city?
-- DENSE_RANK includes all activities tied for the lowest price.
WITH RankedActivities AS (
    SELECT
        City,
        Activity_Title,
        Price,
        DENSE_RANK() OVER (
            PARTITION BY City
            ORDER BY Price
        ) AS Price_Rank
    FROM CommunityPartnership
)
SELECT
    City,
    Activity_Title,
    Price AS Price_SAR
FROM RankedActivities
WHERE Price_Rank = 1
ORDER BY City, Activity_Title;


-- 7. How do advertised monthly salaries differ by city?
SELECT
    City,
    COUNT(*) AS Job_Count,
    ROUND(AVG(Monthly_Salary), 2) AS Average_Monthly_Salary_SAR,
    MAX(Monthly_Salary) AS Highest_Monthly_Salary_SAR
FROM PartTimeJob
GROUP BY City
ORDER BY Average_Monthly_Salary_SAR DESC, City;


-- 8. Which jobs offer salaries above the overall average?
SELECT
    Job_Name,
    City,
    Daily_Work_Hours,
    Monthly_Salary
FROM PartTimeJob
WHERE Monthly_Salary > (
    SELECT AVG(Monthly_Salary)
    FROM PartTimeJob
)
ORDER BY Monthly_Salary DESC, Job_ID;


-- 9. How many office-hour sessions are offered per course?
SELECT
    c.Course_ID,
    c.Course_Name,
    COUNT(o.Res_No) AS Session_Count
FROM Course AS c
LEFT JOIN OfficeHours AS o
    ON c.Course_ID = o.Course_ID
GROUP BY c.Course_ID, c.Course_Name
ORDER BY Session_Count DESC, c.Course_ID;


-- 10. Compare free and paid entertainment trips.
SELECT
    CASE
        WHEN Price = 0 THEN 'Free'
        ELSE 'Paid'
    END AS Price_Category,
    COUNT(*) AS Trip_Count,
    ROUND(AVG(Price), 2) AS Average_Price_SAR
FROM Entertainment
GROUP BY
    CASE
        WHEN Price = 0 THEN 'Free'
        ELSE 'Paid'
    END
ORDER BY Price_Category;
