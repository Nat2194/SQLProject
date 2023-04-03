-- Part 3 - Stored procedure and trigger

-- Create a materialized view for house_student_count using a stored procedure on MySQL
DROP PROCEDURE IF EXISTS refresh_house_student_count;
DELIMITER $$

CREATE PROCEDURE refresh_house_student_count()
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS house_student_count_materialized (
  house_name VARCHAR(255),
  student_count INT
);
    TRUNCATE TABLE house_student_count_materialized;
    INSERT INTO house_student_count_materialized (house_name, student_count)
    SELECT house_name, student_count FROM house_student_count;
END $$

DELIMITER ;

CALL refresh_house_student_count();
SELECT * FROM house_student_count_materialized;

-- Update of the materialized view house_student_count_materialized

-- Add a new student to the table students
INSERT INTO student (student_id, student_name, student_email, year_id, house_id)
VALUES (34, 'Ron Weasley', 'ron.weasley@poudlard.edu', 3, 1);

-- View the contents of the house_student_count_materialized table to see if the new student has been accounted for
SELECT * FROM house_student_count_materialized;

-- Run the refresh_house_student_count() stored procedure
CALL refresh_house_student_count();

-- Re-display the contents of the house_student_count_materialized view

SELECT * FROM house_student_count_materialized;

-- Creation of triggers on the materialized view

-- Create an AFTER INSERT trigger to automatically update the house_student_count_materialized view each time a student is added to the database
DROP TRIGGER IF EXISTS student_insert_trigger;
DELIMITER $$
CREATE TRIGGER student_insert_trigger
AFTER INSERT ON student
FOR EACH ROW
BEGIN
    CALL refresh_house_student_count();
END $$
DELIMITER ;

-- Create an AFTER DELETE trigger to automatically update the house_student_count_materialized view whenever a student is deleted from the database
DROP TRIGGER IF EXISTS student_delete_trigger;
DELIMITER $$
CREATE TRIGGER student_delete_trigger
AFTER DELETE ON student
FOR EACH ROW
BEGIN
    CALL refresh_house_student_count();
END $$
DELIMITER ;

-- Test the triggers

-- View the contents of the house_student_count_materialized table before making any changes
SELECT * FROM house_student_count_materialized;

--  Insert a new student in the students table
INSERT INTO student (student_id, student_name, student_email, year_id, house_id)
VALUES (35, 'Harry Potter', 'harry.potter@poudlard.edu', 3, 1);

-- View the contents of the house_student_count_materialized table after insertion to see if the AFTER INSERT trigger worked
SELECT * FROM house_student_count_materialized;

-- Delete the previously inserted student from the students table
DELETE FROM students WHERE student_name = 'Harry Potter';

-- Display the contents of the house_student_count_materialized table after deletion to check if the AFTER DELETE trigger worked
SELECT * FROM house_student_count_materialized;