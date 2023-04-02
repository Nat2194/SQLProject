CREATE TABLE project (
    id INT NOT NULL AUTO_INCREMENT,
    student_name VARCHAR(255) NOT NULL,
    email VARCHAR(50) NOT NULL,
    registered_course VARCHAR(50) NOT NULL,
    year float NOT NULL,
    house VARCHAR(50) NOT NULL,
    prefet VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);