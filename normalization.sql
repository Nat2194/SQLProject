-- create a separate table for Year to avoid redundancy

CREATE TABLE Years(
year_id INT,
PRIMARY KEY(year_id)
);

-- create table to group attributes with functional dependency on house
CREATE TABLE House(
house_id INT AUTO_INCREMENT,
house_name VARCHAR(255) NOT NULL, -- Changed LOGICAL to VARCHAR(255)
house_prefet VARCHAR(255) NOT NULL, -- Changed LOGICAL to VARCHAR(255)
PRIMARY KEY(house_id),
UNIQUE(house_name),
UNIQUE(house_prefet)
);

-- create table to group attributes with functional dependency on id

CREATE TABLE Student(
student_id INT AUTO_INCREMENT,
student_name VARCHAR(255) NOT NULL, -- Changed LOGICAL to VARCHAR(255)
student_email VARCHAR(255) NOT NULL, -- Changed LOGICAL to VARCHAR(255)
year_id INT NOT NULL,
house_id INT NOT NULL,
PRIMARY KEY(student_id),
UNIQUE(student_name),
UNIQUE(student_email),
FOREIGN KEY(year_id) REFERENCES Years(year_id), -- Changed année to Year
FOREIGN KEY(house_id) REFERENCES House(house_id)
);

-- create a separate table for Course to avoid redundancy

CREATE TABLE Course(
course_id INT AUTO_INCREMENT,
course_name VARCHAR(255) NOT NULL, -- Changed LOGICAL to VARCHAR(255)
PRIMARY KEY(course_id),
UNIQUE(course_name)
);

-- create a pivot table Enrollment to link students to their courses

CREATE TABLE Enrollment(
student_id INT NOT NULL,
course_id INT NOT NULL,
PRIMARY KEY(student_id, course_id),
FOREIGN KEY(student_id) REFERENCES Student(student_id),
FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

-- Populate House table
INSERT INTO House (house_name, house_prefet)
SELECT DISTINCT
  house, 
  prefet
FROM project;

-- Populate Course table
INSERT INTO Course (course_name)
SELECT DISTINCT
  registered_course
FROM project;

-- Populate Years table
INSERT INTO Years (year_id)
SELECT DISTINCT
  year
FROM project;

-- Populate Student table
INSERT INTO Student (student_name, student_email, year_id, house_id)
SELECT DISTINCT
  student_name, 
  email, 
  Years.year_id, 
  House.house_id
FROM project
JOIN Years ON Years.year_id = project.year
JOIN House ON House.house_name = project.house AND House.house_prefet = project.prefet;

-- Populate Enrollment table
INSERT INTO Enrollment (student_id, course_id)
SELECT DISTINCT
  Student.student_id,
  Course.course_id
FROM project
JOIN Student ON Student.student_name = project.student_name AND Student.student_email = project.email
JOIN Course ON Course.course_name = project.registered_course;



-- remove redundant columns from the project table
-- ALTER TABLE project
-- DROP COLUMN student_name,
-- DROP COLUMN email,
-- DROP COLUMN registered_course,
-- DROP COLUMN year,
-- DROP COLUMN house,
-- DROP COLUMN prefet;
