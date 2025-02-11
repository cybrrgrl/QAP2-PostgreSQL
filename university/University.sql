-- drop tables
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS professors;

-- make tables after dropping them

-- students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    school_enrollment_date DATE NOT NULL
);

-- prof. table
CREATE TABLE professors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(100) NOT NULL
);

-- course table
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT NOT NULL,
    professor_id INT NOT NULL,
    CONSTRAINT fk_professor FOREIGN KEY (professor_id) REFERENCES professors(id) ON DELETE CASCADE
);

-- enrollment table
CREATE TABLE enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- sample student data

-- Insert students
INSERT INTO students (first_name, last_name, email, school_enrollment_date) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '2022-09-01'),
('Bob', 'Smith', 'bob.smith@example.com', '2021-09-01'),
('Charlie', 'Brown', 'charlie.brown@example.com', '2023-09-01'),
('Diana', 'Evans', 'diana.evans@example.com', '2020-09-01'),
('Ethan', 'Williams', 'ethan.williams@example.com', '2019-09-01');

-- sample prof. data
INSERT INTO professors (first_name, last_name, department) VALUES
('John', 'Doe', 'Physics'),
('Jane', 'Smith', 'Mathematics'),
('Emily', 'Clark', 'Computer Science'),
('Michael', 'Johnson', 'Biology');

-- sample course data
INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to basic physics concepts', 1),
('Calculus I', 'Differentiation and integration fundamentals', 2),
('Computer Science Fundamentals', 'Basic programming and algorithms', 3);

-- enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-09-05'),  -- Alice in Physics 101
(2, 1, '2023-09-05'),  -- Bob in Physics 101
(3, 2, '2023-09-06'),  -- Charlie in Calculus I
(4, 3, '2023-09-07'),  -- Diana in CS Fundamentals
(5, 1, '2023-09-08');  -- Ethan in Physics 101

-- execute all queries

-- names of students in physics
SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE c.course_name = 'Physics 101';

-- all courses with their respective professors
SELECT c.course_name, CONCAT(p.first_name, ' ', p.last_name) AS professor_name
FROM courses c
JOIN professors p ON c.professor_id = p.id;

-- courses that have enrolled students
SELECT DISTINCT c.course_name
FROM courses c
JOIN enrollments e ON c.id = e.course_id;

-- student email updated
UPDATE students 
SET email = 'alice.newemail@example.com' 
WHERE first_name = 'Alice' AND last_name = 'Johnson';

-- check if updated correctly
SELECT * FROM students WHERE first_name = 'Alice' AND last_name = 'Johnson';

-- remove Bob from physics 101
DELETE FROM enrollments 
WHERE student_id = (SELECT id FROM students WHERE first_name = 'Bob' AND last_name = 'Smith') 
AND course_id = (SELECT id FROM courses WHERE course_name = 'Physics 101');

-- check for the removal of Bob
SELECT * FROM enrollments WHERE student_id = (SELECT id FROM students WHERE first_name = 'Bob' AND last_name = 'Smith');

-- verify queries

-- check for tables
SELECT tablename FROM pg_tables WHERE schemaname = 'public';

-- check data
SELECT * FROM students;
SELECT * FROM professors;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- coubt the rows
SELECT 'students' AS table_name, COUNT(*) FROM students
UNION ALL
SELECT 'professors', COUNT(*) FROM professors
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments;

-- check foreign keys
SELECT conname, conrelid::regclass AS table_name
FROM pg_constraint
WHERE contype = 'f';
