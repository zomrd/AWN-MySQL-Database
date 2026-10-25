USE awn_portfolio;

-- Service category registrations.
-- These counts represent interest, not actual attendance.
CREATE OR REPLACE VIEW vw_service_registrations AS
SELECT
    a.Services_ID,
    a.Services_Name,
    COUNT(b.Stu_ID) AS Registered_Students
FROM Appointment AS a
LEFT JOIN Book AS b
    ON a.Services_ID = b.Services_ID
GROUP BY
    a.Services_ID,
    a.Services_Name;


-- Partnership activity prices by city, including free activities.
CREATE OR REPLACE VIEW vw_activity_prices_by_city AS
SELECT
    City,
    COUNT(*) AS Activity_Count,
    ROUND(AVG(Price), 2) AS Average_Price_SAR,
    MIN(Price) AS Minimum_Price_SAR,
    MAX(Price) AS Maximum_Price_SAR
FROM CommunityPartnership
GROUP BY City;


-- Advertised monthly salaries by city.
CREATE OR REPLACE VIEW vw_job_salaries_by_city AS
SELECT
    City,
    COUNT(*) AS Job_Count,
    ROUND(AVG(Monthly_Salary), 2) AS Average_Monthly_Salary_SAR,
    MIN(Monthly_Salary) AS Minimum_Monthly_Salary_SAR,
    MAX(Monthly_Salary) AS Maximum_Monthly_Salary_SAR
FROM PartTimeJob
GROUP BY City;


-- Example report queries
SELECT *
FROM vw_service_registrations
ORDER BY Registered_Students DESC, Services_ID;

SELECT *
FROM vw_activity_prices_by_city
ORDER BY Average_Price_SAR DESC, City;

SELECT *
FROM vw_job_salaries_by_city
ORDER BY Average_Monthly_Salary_SAR DESC, City;
