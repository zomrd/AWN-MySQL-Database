USE awn_portfolio;

-- Return students assigned to a specific advisor.
DROP PROCEDURE IF EXISTS GetStudentsByAdvisor;

DELIMITER $$

CREATE PROCEDURE GetStudentsByAdvisor (
    IN p_advisor_id VARCHAR(10)
)
READS SQL DATA
BEGIN
    SELECT
        Stu_ID,
        FnameS,
        LnameS,
        Email_S
    FROM Student
    WHERE Advisor_ID = p_advisor_id
    ORDER BY Stu_ID;
END$$

DELIMITER ;


-- Calculate a price after a percentage discount.
-- Invalid inputs return NULL.
DROP FUNCTION IF EXISTS CalculateDiscountedPrice;

DELIMITER $$

CREATE FUNCTION CalculateDiscountedPrice (
    p_price DECIMAL(10, 2),
    p_discount_percent DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    IF p_price IS NULL
       OR p_discount_percent IS NULL
       OR p_price < 0
       OR p_discount_percent < 0
       OR p_discount_percent > 100 THEN
        RETURN NULL;
    END IF;

    RETURN ROUND(
        p_price * (1 - p_discount_percent / 100),
        2
    );
END$$

DELIMITER ;


-- Example 1: Students assigned to advisor E001.
CALL GetStudentsByAdvisor('E001');

-- Example 2: Illustrative 20% discount on trip prices.
-- This query does not change the original prices.
SELECT
    Trip_Name,
    Price AS Original_Price_SAR,
    CalculateDiscountedPrice(Price, 20) AS Discounted_Price_SAR
FROM Entertainment
ORDER BY Discounted_Price_SAR, Trip_ID;
