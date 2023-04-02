-- Display all tables
show tables;

-- Display the columns of the "project" table
select * from project;

-- The number of students in the database 
select count( distinct student_name) from project;

-- The different courses in the database
select distinct registered_course from project;

-- The different houses in the database
select distinct house from project;

-- The different prefects in the database
select distinct prefet from project;

-- What is the prefect for each house?
select distinct house, prefet from project;

-- Count the number of students per year
select count(distinct student_name), year from project group by year;

-- Display the names and emails of students taking the "potion" course
select distinct student_name, email from project where registered_course="potion";

-- Display the students who have a year higher than 2
select distinct student_name from project where year > 2;

-- Sort students alphabetically by name
select distinct student_name from project order by student_name;

-- Find the number of students in each house who are taking the "potion" course
select house, count(distinct student_name) from project where registered_course="potion" group by house;

-- Display the students' houses and the number of students in each house
select house, count(distinct student_name) as num_students from project group by house;

-- Display the number of courses for each year
select count(distinct registered_course) as number_classes, year from project group by year;

-- Display the number of students enrolled in each course
select count(distinct student_name) as number_students, registered_course from project group by registered_course;

-- Display the courses in which students from each house are enrolled
select house, registered_course from project group by house, registered_course order by house;

-- Display the number of students in each year for each house
select house, year, count(distinct student_name) as number_students from project group by house, year;

-- Display the courses in which students in each year are enrolled
select year, registered_course from project group by year, registered_course order by year;

-- Display the student houses and the number of students in each house, sorted in descending order 
select house, count(distinct student_name) as num_students from project group by house order by num_students desc;

-- Display the number of students enrolled in each course, sorted in descending order
select registered_course, count(distinct student_name) as num_students from project group by registered_course order by num_students desc;

-- Display the prefects of each house, sorted alphabetically by house
select distinct house, prefet from project order by house;