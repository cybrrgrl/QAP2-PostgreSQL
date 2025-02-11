-- RUN ALL OF THESE IN PGADMIN TO TEST THE FULL SCRIPT!

SELECT tablename FROM pg_tables WHERE schemaname = 'public';

SELECT * FROM students;
SELECT * FROM professors;
SELECT * FROM courses;
SELECT * FROM enrollments;


SELECT 'students' AS table_name, COUNT(*) FROM students
UNION ALL
SELECT 'professors', COUNT(*) FROM professors
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments;


SELECT conname, conrelid::regclass AS table_name
FROM pg_constraint
WHERE contype = 'f';

SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE c.course_name = 'Physics 101';


SELECT c.course_name, CONCAT(p.first_name, ' ', p.last_name) AS professor_name
FROM courses c
JOIN professors p ON c.professor_id = p.id;


SELECT DISTINCT c.course_name
FROM courses c
JOIN enrollments e ON c.id = e.course_id;