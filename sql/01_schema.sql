-- AWN: University Student Services Database
-- Portfolio edition focused on database design and analytics.
-- Run this script in a new, empty database.

CREATE DATABASE IF NOT EXISTS awn_portfolio
    CHARACTER SET utf8mb4;

USE awn_portfolio;

-- 1. Employees / academic advisors
CREATE TABLE Employee (
    Emp_ID VARCHAR(10) PRIMARY KEY,
    FNameE VARCHAR(100) NOT NULL,
    LNameE VARCHAR(100) NOT NULL,
    Admin_Email VARCHAR(100) NOT NULL UNIQUE,
    Phone_NumberE VARCHAR(15) UNIQUE
) ENGINE = InnoDB;

-- 2. Students and their assigned advisors
CREATE TABLE Student (
    Stu_ID VARCHAR(10) PRIMARY KEY,
    FnameS VARCHAR(100) NOT NULL,
    LnameS VARCHAR(100) NOT NULL,
    Email_S VARCHAR(100) NOT NULL UNIQUE,
    Date_of_Birth DATE NOT NULL,
    Phone_Number VARCHAR(15) UNIQUE,
    Advisor_ID VARCHAR(10),

    CONSTRAINT fk_student_advisor
        FOREIGN KEY (Advisor_ID)
        REFERENCES Employee (Emp_ID)
) ENGINE = InnoDB;

-- 3. Service catalog
CREATE TABLE Appointment (
    Services_ID INT PRIMARY KEY,
    Services_Name VARCHAR(100) NOT NULL UNIQUE
) ENGINE = InnoDB;

-- 4. Student registrations for service categories
-- Each student can register once per service category.
CREATE TABLE Book (
    Stu_ID VARCHAR(10) NOT NULL,
    Services_ID INT NOT NULL,

    PRIMARY KEY (Stu_ID, Services_ID),

    CONSTRAINT fk_book_student
        FOREIGN KEY (Stu_ID)
        REFERENCES Student (Stu_ID),

    CONSTRAINT fk_book_service
        FOREIGN KEY (Services_ID)
        REFERENCES Appointment (Services_ID)
) ENGINE = InnoDB;


-- 5. Courses
CREATE TABLE Course (
    Course_ID VARCHAR(10) PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

-- 6. Office hours
CREATE TABLE OfficeHours (
    Res_No INT PRIMARY KEY AUTO_INCREMENT,
    Emp_ID VARCHAR(10) NOT NULL,
    Course_ID VARCHAR(10) NOT NULL,
    Session_Date DATE NOT NULL,
    Start_Time TIME NOT NULL,
    End_Time TIME NOT NULL,
    Services_ID INT NOT NULL DEFAULT 1,

    FOREIGN KEY (Emp_ID)
        REFERENCES Employee (Emp_ID),

    FOREIGN KEY (Course_ID)
        REFERENCES Course (Course_ID),

    FOREIGN KEY (Services_ID)
        REFERENCES Appointment (Services_ID),

    CHECK (End_Time > Start_Time),
    CHECK (Services_ID = 1)
) ENGINE = InnoDB;

-- 7. Peer education sessions
CREATE TABLE PeerEducation (
    Session_No INT PRIMARY KEY AUTO_INCREMENT,
    Tutor_ID VARCHAR(10) NOT NULL,
    Course_ID VARCHAR(10) NOT NULL,
    Session_Date DATE NOT NULL,
    Start_Time TIME NOT NULL,
    End_Time TIME NOT NULL,
    Services_ID INT NOT NULL DEFAULT 2,

    FOREIGN KEY (Tutor_ID)
        REFERENCES Student (Stu_ID),

    FOREIGN KEY (Course_ID)
        REFERENCES Course (Course_ID),

    FOREIGN KEY (Services_ID)
        REFERENCES Appointment (Services_ID),

    CHECK (End_Time > Start_Time),
    CHECK (Services_ID = 2)
) ENGINE = InnoDB;

-- 8. Community partnership courses and workshops
CREATE TABLE CommunityPartnership (
    CP_ID INT PRIMARY KEY AUTO_INCREMENT,
    Provider_Name VARCHAR(100) NOT NULL,
    Activity_Type VARCHAR(30) NOT NULL,
    Activity_Title VARCHAR(150) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Activity_Date DATE NOT NULL,
    City VARCHAR(50) NOT NULL,
    Services_ID INT NOT NULL DEFAULT 3,

    FOREIGN KEY (Services_ID)
        REFERENCES Appointment (Services_ID),

    CHECK (Price >= 0),
    CHECK (Activity_Type IN ('Course', 'Workshop')),
    CHECK (Services_ID = 3)
) ENGINE = InnoDB;

-- 9. Part-time jobs
CREATE TABLE PartTimeJob (
    Job_ID INT PRIMARY KEY AUTO_INCREMENT,
    Job_Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Daily_Work_Hours DECIMAL(4, 2) NOT NULL,
    Monthly_Salary DECIMAL(10, 2) NOT NULL,
    Services_ID INT NOT NULL DEFAULT 4,

    FOREIGN KEY (Services_ID)
        REFERENCES Appointment (Services_ID),

    CHECK (End_Date >= Start_Date),
    CHECK (Daily_Work_Hours > 0 AND Daily_Work_Hours <= 24),
    CHECK (Monthly_Salary >= 1500),
    CHECK (Services_ID = 4)
) ENGINE = InnoDB;

-- 10. Entertainment trips
CREATE TABLE Entertainment (
    Trip_ID INT PRIMARY KEY AUTO_INCREMENT,
    Trip_Name VARCHAR(100) NOT NULL,
    Trip_Date DATE NOT NULL,
    Trip_Type VARCHAR(20) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Services_ID INT NOT NULL DEFAULT 5,

    FOREIGN KEY (Services_ID)
        REFERENCES Appointment (Services_ID),

    CHECK (Trip_Type IN ('Internal', 'External')),
    CHECK (Price >= 0),
    CHECK (Services_ID = 5)
) ENGINE = InnoDB;
