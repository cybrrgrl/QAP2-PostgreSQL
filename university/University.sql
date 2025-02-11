-- drop tables
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS professors;

-- table creation


CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    school_enrollment_date DATE NOT NULL
);


CREATE TABLE professors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(100) NOT NULL
);


CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT NOT NULL,
    professor_id INT NOT NULL,
    CONSTRAINT fk_professor FOREIGN KEY (professor_id) REFERENCES professors(id) ON DELETE CASCADE
);

-- enrollments (PK)
CREATE TABLE enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- inserting data


INSERT INTO students (first_name, last_name, email, school_enrollment_date) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '2022-09-01'),
('Bob', 'Smith', 'bob.smith@example.com', '2021-09-01'),
('Charlie', 'Brown', 'charlie.brown@example.com', '2023-09-01'),
('Diana', 'Evans', 'diana.evans@example.com', '2020-09-01'),
('Ethan', 'Williams', 'ethan.williams@example.com', '2019-09-01');


INSERT INTO professors (first_name, last_name, department) VALUES
('John', 'Doe', 'Physics'),
('Jane', 'Smith', 'Mathematics'),
('Emily', 'Clark', 'Computer Science'),
('Michael', 'Johnson', 'Biology');


INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to basic physics concepts', 1),
('Calculus I', 'Differentiation and integration fundamentals', 2),
('Computer Science Fundamentals', 'Basic programming and algorithms', 3);


INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-09-05'),  -- Alice in Physics 101
(2, 1, '2023-09-05'),  -- Bob in Physics 101
(3, 2, '2023-09-06'),  -- Charlie in Calculus I
(4, 3, '2023-09-07'),  -- Diana in CS Fundamentals
(5, 1, '2023-09-08');  -- Ethan in Physics 101
