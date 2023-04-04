-- Part 3 - Stored procedure and trigger

-- 2) a )Create a materialized view for house_student_count
CREATE TEMPORARY TABLE IF NOT EXISTS house_student_count_materialized (
  house_name VARCHAR(255),
  student_count INT,
PRIMARY KEY(house_name)
);

-- 2) b) Create a stored procedure to update the materialized view

DROP PROCEDURE IF EXISTS refresh_house_student_count;

DELIMITER $$

CREATE PROCEDURE refresh_house_student_count()
BEGIN
    TRUNCATE TABLE house_student_count_materialized;
    INSERT INTO house_student_count_materialized (house_name, student_count)
    SELECT house_name, student_count FROM house_student_count;
END $$

DELIMITER ;

-- c) Run the stored procedure to update the materialized view

CALL refresh_house_student_count();
SELECT * FROM house_student_count_materialized;