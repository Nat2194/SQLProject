-- Part 3 - Stored procedure and trigger

-- 3) Update of the materialized view house_student_count_materialized

-- a) Add a new student to the table students
INSERT INTO student (student_name, student_email, year_id, house_id)
VALUES ('Ron Weasley', 'ron.weasley@poudlard.edu', 3, 1);


-- b) View the contents of the house_student_count_materialized table to see if the new student has been accounted for
SELECT * FROM house_student_count_materialized;

-- c) Run the refresh_house_student_count() stored procedure
CALL refresh_house_student_count();

-- d) Re-display the contents of the house_student_count_materialized view

SELECT * FROM house_student_count_materialized;