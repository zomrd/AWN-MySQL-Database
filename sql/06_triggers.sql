USE awn_portfolio;

-- Audit history for changes to advertised monthly salaries.
CREATE TABLE IF NOT EXISTS JobSalaryAudit (
    Audit_ID BIGINT PRIMARY KEY AUTO_INCREMENT,
    Job_ID INT NOT NULL,
    Old_Salary DECIMAL(10, 2) NOT NULL,
    New_Salary DECIMAL(10, 2) NOT NULL,
    Changed_At TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_salary_audit_job (Job_ID)
) ENGINE = InnoDB;

-- No foreign key is used here so the audit history remains
-- available even if the original job is later deleted.

DROP TRIGGER IF EXISTS trg_job_salary_audit;

DELIMITER $$

CREATE TRIGGER trg_job_salary_audit
AFTER UPDATE ON PartTimeJob
FOR EACH ROW
BEGIN
    IF NEW.Monthly_Salary <> OLD.Monthly_Salary THEN
        INSERT INTO JobSalaryAudit (
            Job_ID,
            Old_Salary,
            New_Salary
        )
        VALUES (
            NEW.Job_ID,
            OLD.Monthly_Salary,
            NEW.Monthly_Salary
        );
    END IF;
END$$

DELIMITER ;


-- Optional manual test:
-- Run these statements together after loading the sample data.
-- ROLLBACK restores the salary and removes the test audit record.

/*
START TRANSACTION;

UPDATE PartTimeJob
SET Monthly_Salary = Monthly_Salary + 100
WHERE Job_ID = 1;

SELECT *
FROM JobSalaryAudit
WHERE Job_ID = 1
ORDER BY Audit_ID DESC;

ROLLBACK;
*/
