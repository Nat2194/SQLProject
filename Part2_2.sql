-- Part 2 - Views

-- Create a logical view that displays the name, email, and home of each student taking a Potions course
CREATE VIEW PotionStudents AS
SELECT s.student_name, s.student_email, h.house_name
FROM student s
JOIN house h ON s.house_id = h.house_id
JOIN enrollment e ON s.student_id = e.student_id
JOIN course c ON e.course_id = c.course_id
WHERE c.course_name = 'Potion';

-- display the result of the view
SELECT * FROM PotionStudents;

-- Add 2 students who are taking a potions course
INSERT INTO student (student_name, student_email, year_id, house_id)
VALUES ('Hermione Granger', 'hermione.granger@poudlard.edu', 3, 1), 
       ('Neville Longbottom', 'neville.longbottom@poudlard.edu', 3, 4);

INSERT INTO enrollment (student_id, course_id)
VALUES (32, 1), (33, 1);

-- Display (again) the result of the view
SELECT * FROM PotionStudents;

-- Create a house_student_count view that groups students by house and counts the number of students in each house.

CREATE VIEW house_student_count AS
SELECT house.house_name, COUNT(student.student_id) AS student_count
FROM student
JOIN house ON student.house_id = house.house_id
GROUP BY house.house_name;

-- Try to change the column containing the number of students in a house. For example, for the house Gryffindor, set the number of students to 10.
UPDATE house_student_count
SET student_count = 10
WHERE house_name = 'Gryffindor';

-- Does this query generate an error? And if the house_student_count view had been a normal table, would this query have worked?

-- This query will raise an error because the view house_student_count is a logical view, not a materialized view.
-- Logical views are based on the underlying tables and are not directly updatable.
-- To update the data in a logical view, you need to update the underlying tables.
-- If house_student_count had been a normal table, the query would have worked.