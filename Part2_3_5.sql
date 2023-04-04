-- Part 3 - Stored procedure and trigger

-- 5) Test the triggers of the materialized view house_student_count_materialized

-- a) View the contents of the house_student_count_materialized table before making any changes
SELECT * FROM house_student_count_materialized;

-- b)  Insert a new student in the students table
INSERT INTO student (student_id, student_name, student_email, year_id, house_id)
VALUES (35, 'Harry Potter', 'harry.potter@poudlard.edu', 3, 1);

-- c) View the contents of the house_student_count_materialized table after insertion to see if the AFTER INSERT trigger worked
SELECT * FROM house_student_count_materialized;

-- d) Delete the previously inserted student from the student table
DELETE FROM student WHERE student_name = 'Harry Potter';

-- e) Display the contents of the house_student_count_materialized table after deletion to check if the AFTER DELETE trigger worked
SELECT * FROM house_student_count_materialized;