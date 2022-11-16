CREATE DATABASE courses;
USE courses;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    lastname VARCHAR(80) NOT NULL,
    surname VARCHAR(80)
);

CREATE TABLE authors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    lastname VARCHAR(80) NOT NULL,
    surname VARCHAR(80)
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    price INT NOT NULL DEFAULT 0,
    author INT,
    CONSTRAINT courses_author_fk
        FOREIGN KEY (author)
        REFERENCES authors(id)
        ON DELETE CASCADE
);

CREATE TABLE courses_participants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course INT NOT NULL,
    student INT NOT NULL,
    CONSTRAINT courses_participants_course_fk
        FOREIGN KEY (course) REFERENCES courses(id)
        ON DELETE CASCADE,
    CONSTRAINT courses_participants_student_fk
        FOREIGN KEY (student) REFERENCES students(id)
        ON DELETE CASCADE
);

INSERT INTO authors (name, lastname, surname)
VALUES
    ('Олег', 'Василенко', 'Васильович'),
    ('Андрій', 'Заболотний', 'Володимирович');
    
INSERT INTO courses (title, price, author)
VALUES
    ('PHP For Beginners', 0, 1),
    ('PHP Advanced Level', 100, 1),
    ('DevOps Fundamentals', 0, 2),
    ('Docker For Beginners', 0, 2),
    ('Docker Next Level', 150, 2),
    ('Azure Cloud For Professionals', 200, 2),
    ('Linux Administrating', 150, 2),
    ('Bash Scripting', 0, 2);

INSERT INTO students (name, lastname, surname)
VALUES
    ('Михайло', 'Зубенко', 'Петрович'),
    ('Анастасія', 'Скрипка', 'Андріївна'),
    ('Анатолій', 'Скрябін', 'Валентинович'),
    ('Людмила', 'Жигун', 'Валеріївна');

INSERT INTO courses_participants (student, course)
VALUES
    (1, 1),
    (1, 4),
    (1, 5),
    (2, 3),
    (2, 7),
    (2, 6),
    (3, 8),
    (4, 2),
    (4, 2);
