-- Part 1 - Index

-- enable profiling
SET profiling = 1; 

-- count the number of students who are in the "Gryffindor" house
SELECT COUNT(*) AS num_students
FROM Student
JOIN House ON House.house_id = Student.house_id
WHERE House.house_name = 'Gryffondor';

-- measure the time of the request with the command SHOW PROFIL

-- show profiling information
SHOW PROFILE;

-- disable profiling
SET profiling = 0;

-- add an index on the "house_id" column of the "students" table ;
ALTER TABLE Student ADD INDEX idx_house_id (house_id);

-- measure again the time of the query after adding the index ;

-- enable profiling
SET profiling = 1; 

-- count the number of students who are in the "Gryffindor" house
SELECT COUNT(*) AS num_students
FROM Student
JOIN House ON House.house_id = Student.house_id
WHERE House.house_name = 'Gryffondor';

-- show profiling information
SHOW PROFILE;

-- disable profiling
SET profiling = 0;

-- measure again the time of the query but without index

-- enable profiling
SET profiling = 1;

SELECT COUNT(*) AS num_students
FROM Student
IGNORE INDEX (idx_house_id)
JOIN House ON House.house_id = Student.house_id
WHERE House.house_name = 'Gryffondor';

-- show profiling information
SHOW PROFILE;

-- disable profiling
SET profiling = 0; 

-- 3)

-- Query a:

-- enable profiling
SET profiling = 1;

-- run the query a

-- Measure the time of the query
SET profiling = 1;
SELECT House.house_name, Course.course_name, COUNT(*) AS num_students
FROM Student
JOIN House ON Student.house_id = House.house_id
JOIN Enrollment ON Student.student_id = Enrollment.student_id
JOIN Course ON Enrollment.course_id = Course.course_id
GROUP BY House.house_name, Course.course_name
ORDER BY num_students DESC;
SHOW PROFILE;

-- Add an index on the course_id column in the Enrollment table
ALTER TABLE Enrollment ADD INDEX (course_id);

-- Measure the time of the query again after adding the index
SET profiling = 1;
SELECT House.house_name, Course.course_name, COUNT(*) AS num_students
FROM Student
JOIN House ON Student.house_id = House.house_id
JOIN Enrollment ON Student.student_id = Enrollment.student_id
JOIN Course ON Enrollment.course_id = Course.course_id
GROUP BY House.house_name, Course.course_name
ORDER BY num_students DESC;
SHOW PROFILE;

-- Run the query b

-- Measure the time of the query
SET profiling = 1;
SELECT student_name, student_email
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id
WHERE Enrollment.student_id IS NULL;
SHOW PROFILE;
SET profiling = 0;

-- Add an index on the student_id column of the Enrollment table
CREATE INDEX idx_enrollment_student_id ON Enrollment (student_id);

-- Measure the time of the query again
SET profiling = 1;
SELECT student_name, student_email
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id
WHERE Enrollment.student_id IS NULL;
SHOW PROFILE;
SET profiling = 0;

-- Query c

-- the index already exists

-- Measure the time of the query ignoring the index
SET profiling = 1;
SELECT house.house_name, COUNT(*) AS num_students
FROM enrollment
IGNORE INDEX (idx_enrollment_student_id)
JOIN student IGNORE INDEX (idx_house_id)
ON enrollment.student_id = student.student_id
JOIN house ON student.house_id = house.house_id
JOIN course ON enrollment.course_id = course.course_id
WHERE course_name IN ('Potions', 'Sortilèges', 'Botanique')
GROUP BY house.house_name;
SHOW PROFILE;
SET profiling = 0;

-- Measure the time of the query again with the index
SET profiling = 1;
SELECT house.house_name, COUNT(*) AS num_students
FROM enrollment
JOIN student ON enrollment.student_id = student.student_id
JOIN house ON student.house_id = house.house_id
JOIN course ON enrollment.course_id = course.course_id
WHERE course_name IN ('Potions', 'Sortilèges', 'Botanique')
GROUP BY house.house_name;
SHOW PROFILE;
SET profiling = 0;

-- Query d

-- Run the query without the index
SET profiling = 1;
SELECT s.student_name, s.student_email
FROM Student s IGNORE INDEX(idx_house_id)
JOIN (
 SELECT Enrollment.student_id, year_id, COUNT(DISTINCT course_id) AS num_courses
 FROM Enrollment
 JOIN Student ON Enrollment.student_id = Student.student_id
 GROUP BY student_id, year_id
) AS sub
ON s.student_id = sub.student_id AND s.year_id = sub.year_id
JOIN (
 SELECT year_id, COUNT(DISTINCT course_id) AS num_courses
 FROM Enrollment
 JOIN Student ON Enrollment.student_id = Student.student_id
 GROUP BY year_id
) AS total
ON s.year_id = total.year_id AND sub.num_courses = total.num_courses
WHERE sub.num_courses = total.num_courses;
SHOW PROFILE;
SET profiling = 0;

-- Make the query again with the index
SET profiling = 1;
SELECT s.student_name, s.student_email
FROM Student s
JOIN (
 SELECT Enrollment.student_id, year_id, COUNT(DISTINCT course_id) AS num_courses
 FROM Enrollment
 JOIN Student ON Enrollment.student_id = Student.student_id
 GROUP BY student_id, year_id
) AS sub
ON s.student_id = sub.student_id AND s.year_id = sub.year_id
JOIN (
 SELECT year_id, COUNT(DISTINCT course_id) AS num_courses
 FROM Enrollment
 JOIN Student ON Enrollment.student_id = Student.student_id
 GROUP BY year_id
) AS total
ON s.year_id = total.year_id AND sub.num_courses = total.num_courses
WHERE sub.num_courses = total.num_courses;
SHOW PROFILE;
SET profiling = 0;
