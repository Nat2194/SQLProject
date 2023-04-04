-- Part 3 - Stored procedure and trigger

-- 4) Creation of triggers on the materialized view

-- a) Create an AFTER INSERT trigger to automatically update the house_student_count_materialized view each time a student is added to the database

DROP TRIGGER IF EXISTS student_insert_trigger;
DELIMITER $$
CREATE TRIGGER student_insert_trigger
AFTER INSERT ON student
FOR EACH ROW
BEGIN
  -- Increment the student count for the house of the new student
  UPDATE house_student_count_materialized
  SET student_count = student_count + 1
  WHERE house_name = (SELECT house_name FROM house WHERE house_id = NEW.house_id);
END $$
DELIMITER ;

-- b) Create an AFTER DELETE trigger to automatically update the house_student_count_materialized view whenever a student is deleted from the database
DROP TRIGGER IF EXISTS student_delete_trigger;
DELIMITER $$
CREATE TRIGGER student_delete_trigger
AFTER DELETE ON student
FOR EACH ROW
BEGIN
  -- Decrement the student count for the house of the deleted student
  UPDATE house_student_count_materialized
  SET student_count = student_count - 1
  WHERE house_name = (SELECT house_name FROM house WHERE house_id = OLD.house_id);
END $$
DELIMITER ;